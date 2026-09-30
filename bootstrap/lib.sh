#!/usr/bin/env bash
# shared function library for the dotfiles bootstrap.
# library file: sourcing this only defines functions.

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# interactive-safety: git fail fast instead of blocking on a credential prompt for a bad/private URL.
export GIT_TERMINAL_PROMPT=0

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# --- logging ---
if [ -t 1 ]; then
  C_G=$'\e[32m'; C_Y=$'\e[33m'; C_R=$'\e[31m'; C_B=$'\e[34m'; C_0=$'\e[0m'
else
  C_G=; C_Y=; C_R=; C_B=; C_0=
fi
log()  { printf '%s▶%s %s\n' "$C_B" "$C_0" "$*"; }
ok()   { printf '%s✓%s %s\n' "$C_G" "$C_0" "$*"; }
# deps.sh fails the task when any were logged, so ./install's summary shows them
LIB_ISSUES=0
warn() { LIB_ISSUES=$((LIB_ISSUES + 1)); printf '%s!%s %s\n' "$C_Y" "$C_0" "$*" >&2; }
err()  { LIB_ISSUES=$((LIB_ISSUES + 1)); printf '%s✗%s %s\n' "$C_R" "$C_0" "$*" >&2; }

# list the tasks task.sh recorded as failed, each with the tail of its stderr log.
print_failure_summary() {   # $1=log dir  $2=tail lines
  local dir="$1" lines="${2:-15}" rc name logf
  [ -s "$dir/failed" ] || return 0

  printf '\n%s✗ %s task(s) failed%s  (full logs: %s)\n' \
    "$C_R" "$(wc -l < "$dir/failed" | tr -d ' ')" "$C_0" "${dir/#$HOME/~}"
  while IFS=$'\t' read -r rc name logf; do
    printf '\n  %s✗ %s%s  %s(exit %s)%s\n' "$C_R" "$name" "$C_0" "$C_Y" "$rc" "$C_0"
    # keep only the final redraw of \r-updated progress lines, drop blanks
    awk -F'\r' '{ for (i = NF; i > 1 && $i == ""; i--); if ($i != "") print $i }' "$logf" 2>/dev/null \
      | tail -n "$lines" | sed "s/^/    ${C_B}│${C_0} /" | grep . || printf '    %s│%s (no stderr output)\n' "$C_B" "$C_0"
  done < "$dir/failed"
  echo
}

# ---- detection utils ---
have() { command -v "$1" >/dev/null 2>&1; }

detect_os() {
  case "$(uname -s)" in
    Darwin) echo macos ;;
    Linux)  echo linux ;;
    *)      echo unknown ;;
  esac
}

detect_pkgmgr() {
  if   have apt-get; then echo apt
  elif have dnf;     then echo dnf
  elif have yum;     then echo yum
  else echo none; fi
}

# --- common helpers ---
clone_if_missing() {   # $1=url  $2=dest
  [ -d "$2" ] && { ok "present: ${2/#$HOME/~}"; return 0; }
  git clone --depth=1 "$1" "$2" && ok "cloned $(basename "$2")" || warn "clone failed: $1"
}

# apt-get install, hardened against interactive prompts
apt_install() { $SUDO DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a apt-get install -y "$@"; }

# homebrew installer
install_brew() {
  have brew || NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # put brew on PATH (Apple Silicon / Intel / Linuxbrew)
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null \
        || /usr/local/bin/brew shellenv 2>/dev/null \
        || /home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null)"

  have brew || { err "Homebrew install failed -- nothing from the Brewfile will be installed"; return 1; }
}

# brew bundle from the Brewfile. cask GUI apps are macOs-only
brew_bundle() {   # $1 = 1 → strip casks (Linux), 0 → full Brewfile (macOS)
  if [ "${1:-0}" -eq 1 ]; then
    local tmp; tmp="$(mktemp)"
    grep -vE '^[[:space:]]*cask ' "$LIB_DIR/Brewfile" > "$tmp"
    brew bundle --file "$tmp" || warn "brew bundle reported errors (continuing)"
    rm -f "$tmp"

  else
    brew bundle --file "$LIB_DIR/Brewfile" || warn "brew bundle reported errors (continuing)"

  fi
}

# oh-my-zsh + p10k + OMZ plugins + TPM + uv + colorscript
install_common_clones() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    # --keep-zshrc: never create/overwrite ~/.zshrc -- dotbot symlinks ours.
    RUNZSH=no CHSH=no sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
      "" --unattended --keep-zshrc || warn "oh-my-zsh install failed"
  fi

  local ZC="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  clone_if_missing https://github.com/romkatv/powerlevel10k.git                   "$ZC/themes/powerlevel10k"
  clone_if_missing https://github.com/zsh-users/zsh-autosuggestions               "$ZC/plugins/zsh-autosuggestions"
  clone_if_missing https://github.com/zdharma-continuum/fast-syntax-highlighting  "$ZC/plugins/fast-syntax-highlighting"
  clone_if_missing https://github.com/Aloxaf/fzf-tab                              "$ZC/plugins/fzf-tab"
  clone_if_missing https://github.com/fdellwing/zsh-bat                           "$ZC/plugins/zsh-bat"
  clone_if_missing https://github.com/tmux-plugins/tpm                            "$HOME/.tmux/plugins/tpm"

  have uv || curl -LsSf https://astral.sh/uv/install.sh | sh || warn "uv install failed"

  # colorscript -- nvim dashboard header
  if ! have colorscript; then
    local tmp scs_sudo=""; [ "$(id -u)" -ne 0 ] && scs_sudo="sudo"
    tmp="$(mktemp -d)"
    git clone --depth=1 https://gitlab.com/dwt1/shell-color-scripts "$tmp" \
      && ( cd "$tmp" && $scs_sudo make install ) && ok "installed colorscript" \
      || warn "colorscript install failed (optional; dashboard degrades gracefully)"
    rm -rf "$tmp"
  fi
}

# --- Linux helpers ---
# make zsh the login shell for Linux/EC2
set_default_shell_zsh() {
  local sudo="" zbin
  [ "$(id -u)" -ne 0 ] && sudo=sudo
  zbin="$(command -v zsh)" || return 0
  [ -n "$zbin" ] || return 0
  [ "$(basename "${SHELL:-}")" = zsh ] && return 0
  grep -qx "$zbin" /etc/shells 2>/dev/null || echo "$zbin" | $sudo tee -a /etc/shells >/dev/null 2>&1 || true
  $sudo chsh -s "$zbin" "${USER:-$(id -un)}" 2>/dev/null \
    && ok "default shell → zsh (log out/in to take effect)" \
    || warn "couldn't set default shell -- run manually: chsh -s $zbin"
}

# core packages for the minimal path.
linux_install_core() {
  case "$PM" in
    apt)     $SUDO apt-get update && apt_install $CORE ;;
    dnf|yum) $SUDO "$PM" install -y $CORE ;;
    *)       warn "unknown Linux package manager -- install these manually: $CORE" ;;
  esac
}

# minimal distro packages needed to bootstrap homebrew on Linux.
linux_install_brew_prereqs() {
  case "$PM" in
    apt)
      $SUDO apt-get update
      apt_install build-essential procps curl file git ;;

    dnf|yum)
      $SUDO "$PM" groupinstall -y "Development Tools" 2>/dev/null \
        || $SUDO "$PM" install -y gcc gcc-c++ make

      $SUDO "$PM" install -y procps-ng curl file git libxcrypt-compat 2>/dev/null \
        || $SUDO "$PM" install -y procps-ng curl file git ;;

    *) warn "install Homebrew prereqs manually (gcc, make, curl, git)" ;;
  esac
}

# --- Linux ---
install_linux() {   # $1 = minimal [0-1]
  local minimal="$1"
  local PM SUDO CORE
  PM="$(detect_pkgmgr)"
  SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO=sudo
  CORE="git git-lfs bash vim tmux curl unzip"

  if [ "$minimal" -eq 1 ]; then
    linux_install_core          # lean, bash-only, distro packages
    return 0
  fi

  # full stack: install via homebrew
  linux_install_brew_prereqs
  install_brew || return 1
  brew_bundle 1                 # strip GUI apps

  # claude-code: native installer
  if ! have claude && [ ! -x "$HOME/.local/bin/claude" ]; then
    curl -fsSL https://claude.ai/install.sh | bash >/dev/null 2>&1 \
      && ok "installed claude-code" || warn "claude-code install failed"
  fi

  # codex: the brew cask is stripped on Linux, so install from npm (node comes from the Brewfile)
  if ! have codex; then
    npm install -g @openai/codex >/dev/null 2>&1 \
      && ok "installed codex" || warn "codex install failed"
  fi

  install_common_clones         # oh-my-zsh, p10k, TPM, uv, colorscript
  set_default_shell_zsh
}

# --- macOS ---
install_macos() {   # $1 = minimal [0-1]
  local minimal="$1"
  install_brew || return 1

  if [ "$minimal" -eq 1 ]; then
    brew install git git-lfs bash vim tmux

  else
    brew_bundle 0               # full Brewfile incl. casks
    install_common_clones
    bash "$LIB_DIR/macos.sh" || warn "macos.sh failed"

  fi
}
