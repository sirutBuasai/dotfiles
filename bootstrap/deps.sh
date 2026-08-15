#!/usr/bin/env bash
# bootstrap/deps.sh — install all dependencies (macOS or Linux).
#   ./deps.sh            full stack
#   ./deps.sh --minimal  primitive set only (git/zsh/bash/vim/tmux + basics) for a bare box
# Not `set -e`: individual installs may fail; we warn and continue.
set -o pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/lib.sh"

MINIMAL=0
[ "${1:-}" = "--minimal" ] && MINIMAL=1
log "Installing dependencies  (OS=$OS, minimal=$MINIMAL)"

clone_if_missing() {   # $1=url  $2=dest
  [ -d "$2" ] && { ok "present: ${2/#$HOME/~}"; return 0; }
  git clone --depth=1 "$1" "$2" && ok "cloned $(basename "$2")" || warn "clone failed: $1"
}

install_common_clones() {   # oh-my-zsh + p10k + OMZ plugins + TPM + uv (both platforms)
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
      "" --unattended || warn "oh-my-zsh install failed"
  fi
  local ZC="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  clone_if_missing https://github.com/romkatv/powerlevel10k.git                  "$ZC/themes/powerlevel10k"
  clone_if_missing https://github.com/zsh-users/zsh-autosuggestions               "$ZC/plugins/zsh-autosuggestions"
  clone_if_missing https://github.com/zdharma-continuum/fast-syntax-highlighting  "$ZC/plugins/fast-syntax-highlighting"
  clone_if_missing https://github.com/Aloxaf/fzf-tab                              "$ZC/plugins/fzf-tab"
  clone_if_missing https://github.com/fdellwing/zsh-bat                           "$ZC/plugins/zsh-bat"
  clone_if_missing https://github.com/tmux-plugins/tpm                            "$HOME/.tmux/plugins/tpm"
  have uv || curl -LsSf https://astral.sh/uv/install.sh | sh || warn "uv install failed"
}

case "$OS" in
  macos)
    if ! have brew; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"
    if [ "$MINIMAL" -eq 1 ]; then
      brew install git git-lfs zsh bash vim tmux
    else
      brew bundle --file "$DIR/Brewfile" || warn "brew bundle reported errors (continuing)"
      install_common_clones
      # one-time macOS system tweaks (idempotent: key-repeat, Touch-ID sudo)
      [ -f "$DIR/macos.sh" ] && bash "$DIR/macos.sh" || true
    fi
    ;;

  linux)
    PM="$(detect_pkgmgr)"
    SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
    core="git git-lfs zsh bash vim tmux curl unzip"
    case "$PM" in
      apt)
        $SUDO apt-get update
        $SUDO apt-get install -y $core build-essential xdg-utils fontconfig
        [ "$MINIMAL" -eq 0 ] && $SUDO apt-get install -y \
          jq ripgrep fd-find bat fzf zoxide golang nodejs npm python3 python3-pip
        ;;
      dnf|yum)
        $SUDO "$PM" install -y $core xdg-utils fontconfig
        $SUDO "$PM" groupinstall -y "Development Tools" 2>/dev/null \
          || $SUDO "$PM" install -y gcc gcc-c++ make
        # AL2023 has no EPEL → jq/go/node/python from base repo; Rust CLIs via cargo (below)
        [ "$MINIMAL" -eq 0 ] && $SUDO "$PM" install -y jq golang nodejs npm python3 python3-pip
        ;;
      *) warn "unknown Linux package manager — install these manually: $core" ;;
    esac

    if [ "$MINIMAL" -eq 0 ]; then
      # Rust toolchain + CLIs absent from AL2023 default repos
      have cargo || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
      for pair in "ripgrep:rg" "fd-find:fd" "bat:bat" "zoxide:zoxide" "tree-sitter-cli:tree-sitter"; do
        crate="${pair%%:*}"; bin="${pair##*:}"
        have "$bin" || cargo install "$crate" || warn "cargo install $crate failed"
      done
      have sesh || { have go && go install github.com/joshmedeski/sesh/v2@latest \
        || warn "install Go, then: go install github.com/joshmedeski/sesh/v2@latest"; }
      have nvim || warn "neovim missing → install the AppImage (needs >=0.11 for native LSP): https://github.com/neovim/neovim/releases"
      install_common_clones
    fi
    ;;

  *) err "unsupported OS: $(uname -s)"; exit 1 ;;
esac

ok "dependency install done."
[ "$MINIMAL" -eq 1 ] && log "Minimal set installed. Re-run without --minimal for the full stack."
