#!/usr/bin/env bash
# shared function library for the dotfiles bootstrap.
# library file: sourcing this only defines functions.

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# interactive-safety: git fail fast instead of blocking on a credential prompt for a bad/private URL.
export GIT_TERMINAL_PROMPT=0

# --- logging ---
if [ -t 1 ]; then
  C_G=$'\e[32m'; C_Y=$'\e[33m'; C_R=$'\e[31m'; C_B=$'\e[34m'; C_0=$'\e[0m'
else
  C_G=; C_Y=; C_R=; C_B=; C_0=
fi
log()  { printf '%s▶%s %s\n' "$C_B" "$C_0" "$*"; }
ok()   { printf '%s✓%s %s\n' "$C_G" "$C_0" "$*"; }
warn() { printf '%s!%s %s\n' "$C_Y" "$C_0" "$*" >&2; }
err()  { printf '%s✗%s %s\n' "$C_R" "$C_0" "$*" >&2; }

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

# oh-my-zsh + p10k + OMZ plugins + TPM + uv + colorscript
install_common_clones() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    # --keep-zshrc: never create/overwrite ~/.zshrc — dotbot symlinks ours.
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
    || warn "couldn't set default shell — run manually: chsh -s $zbin"
}

# core packages via the distro package manager,
# uses $PM / $SUDO / $CORE from the `install_linux`.
linux_install_core() {   # $1 = minimal [0-1]
  case "$PM" in
    apt)
      $SUDO apt-get update
      apt_install $CORE build-essential xdg-utils
      [ "$1" -eq 0 ] && apt_install \
        zsh jq ripgrep fd-find bat fzf zoxide golang nodejs npm python3 python3-pip
      ;;

    dnf|yum)
      $SUDO "$PM" install -y $CORE xdg-utils
      $SUDO "$PM" groupinstall -y "Development Tools" 2>/dev/null \
        || $SUDO "$PM" install -y gcc gcc-c++ make
      # AL2023 has no EPEL → jq/go/node/python from base repo; Rust CLIs via cargo
      [ "$1" -eq 0 ] && $SUDO "$PM" install -y zsh jq golang nodejs npm python3 python3-pip
      ;;

    *) warn "unknown Linux package manager — install these manually: $CORE" ;;
  esac
}

# full-stack dev tools absent from distro repos,
# uses $PM / $SUDO / $CORE from the `install_linux`.
linux_install_dev_extras() {
  # github cli
  have gh || $SUDO "$PM" install -y gh 2>/dev/null \
    || warn "gh not in default repos — install manually if you push over HTTPS: https://github.com/cli/cli#installation"

  # rust toolchain + cli
  have cargo || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

  # ripgrep, fd, bat, zoxide, treesitter: install via cargo
  local pair crate bin
  for pair in "ripgrep:rg" "fd-find:fd" "bat:bat" "zoxide:zoxide" "tree-sitter-cli:tree-sitter"; do
    crate="${pair%%:*}"; bin="${pair##*:}"
    have "$bin" || cargo install "$crate" || warn "cargo install $crate failed"
  done

  # sesh, fzf, yq: install via go
  local gopkg pkg
  for gopkg in \
    "sesh:github.com/joshmedeski/sesh/v2@latest" \
    "fzf:github.com/junegunn/fzf@latest" \
    "yq:github.com/mikefarah/yq/v4@latest"; do
    bin="${gopkg%%:*}"; pkg="${gopkg#*:}"
    have "$bin" || { have go && go install "$pkg"; } || warn "go install $pkg failed (need Go)"
  done

  # neovim: fetch the official AppImage
  if ! have nvim; then
    local nv_arch=x86_64; [ "$(uname -m)" = aarch64 ] && nv_arch=arm64
    mkdir -p "$HOME/.local/bin"
    if curl -fL -o "$HOME/.local/bin/nvim" \
         "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${nv_arch}.appimage"; then
      chmod +x "$HOME/.local/bin/nvim"
      "$HOME/.local/bin/nvim" --version >/dev/null 2>&1 \
        && ok "installed neovim AppImage → ~/.local/bin/nvim" \
        || warn "nvim AppImage needs FUSE — run: ~/.local/bin/nvim --appimage-extract, then symlink squashfs-root/usr/bin/nvim"
    else
      warn "neovim AppImage download failed — install manually: https://github.com/neovim/neovim/releases"
    fi
  fi

  # kubectl, helm, terraform
  mkdir -p "$HOME/.local/bin"
  if ! have kubectl; then
    local k_arch=amd64 kver; [ "$(uname -m)" = aarch64 ] && k_arch=arm64
    kver="$(curl -Ls https://dl.k8s.io/release/stable.txt)"
    curl -fLo "$HOME/.local/bin/kubectl" "https://dl.k8s.io/release/${kver}/bin/linux/${k_arch}/kubectl" \
      && chmod +x "$HOME/.local/bin/kubectl" && ok "installed kubectl ${kver}" \
      || warn "kubectl download failed"
  fi
  have helm || { curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
    || warn "helm install failed"; }
  have terraform || linux_install_terraform
}
# HashiCorp repo per package manager,
# uses $PM / $SUDO / $CORE from the `install_linux`.
linux_install_terraform() {
  case "$PM" in
    apt)
      curl -fsSL https://apt.releases.hashicorp.com/gpg \
        | $SUDO gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg 2>/dev/null
      . /etc/os-release 2>/dev/null

      echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${VERSION_CODENAME:-stable} main" \
        | $SUDO tee /etc/apt/sources.list.d/hashicorp.list >/dev/null

      $SUDO apt-get update && apt_install terraform || warn "terraform apt install failed" ;;

    dnf|yum)
      $SUDO "$PM" install -y dnf-plugins-core 2>/dev/null

      $SUDO "$PM" config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo 2>/dev/null \
        || $SUDO "$PM" config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo 2>/dev/null

      $SUDO "$PM" install -y terraform || warn "terraform dnf install failed" ;;

    *) warn "terraform: install manually (unknown package manager)" ;;
  esac
}

# --- Linux ---
install_linux() {   # $1 = minimal [0-1]
  local minimal="$1"
  local PM SUDO CORE
  PM="$(detect_pkgmgr)"
  SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO=sudo
  CORE="git git-lfs bash vim tmux curl unzip"

  linux_install_core "$minimal"
  if [ "$minimal" -eq 0 ]; then
    linux_install_dev_extras
    install_common_clones
    set_default_shell_zsh
  fi
}

# --- macOS ---
install_macos() {   # $1 = minimal [0-1]
  local minimal="$1"
  if ! have brew; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"

  if [ "$minimal" -eq 1 ]; then
    brew install git git-lfs bash vim tmux

  else
    brew bundle --file "$LIB_DIR/Brewfile" || warn "brew bundle reported errors (continuing)"
    install_common_clones
    # macOS system preferences
    [ -f "$LIB_DIR/macos.sh" ] && bash "$LIB_DIR/macos.sh" || true

  fi
}
