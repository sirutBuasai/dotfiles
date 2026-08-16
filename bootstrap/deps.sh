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
  # colorscript — snacks dashboard header (no brew formula; build from source, both platforms)
  if ! have colorscript; then
    local tmp scs_sudo=""; [ "$(id -u)" -ne 0 ] && scs_sudo="sudo"
    tmp="$(mktemp -d)"
    git clone --depth=1 https://gitlab.com/dwt1/shell-color-scripts "$tmp" \
      && ( cd "$tmp" && $scs_sudo make install ) && ok "installed colorscript" \
      || warn "colorscript install failed (optional; dashboard degrades gracefully)"
    rm -rf "$tmp"
  fi
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
      # GitHub CLI — used as the git credential helper (gh auth git-credential)
      have gh || $SUDO "$PM" install -y gh 2>/dev/null \
        || warn "gh not in default repos — install manually if you push over HTTPS: https://github.com/cli/cli#installation"
      # Rust toolchain + CLIs absent from AL2023 default repos
      have cargo || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
      for pair in "ripgrep:rg" "fd-find:fd" "bat:bat" "zoxide:zoxide" "tree-sitter-cli:tree-sitter"; do
        crate="${pair%%:*}"; bin="${pair##*:}"
        have "$bin" || cargo install "$crate" || warn "cargo install $crate failed"
      done
      have sesh || { have go && go install github.com/joshmedeski/sesh/v2@latest \
        || warn "install Go, then: go install github.com/joshmedeski/sesh/v2@latest"; }
      # fzf: not a Rust crate and absent from AL2023 repos → install via Go (no-op if apt already did)
      have fzf || { have go && go install github.com/junegunn/fzf@latest \
        || warn "install fzf manually: https://github.com/junegunn/fzf#installation"; }
      # neovim: distro repos are usually <0.11 → fetch the official AppImage
      if ! have nvim; then
        NV_ARCH=x86_64; [ "$(uname -m)" = aarch64 ] && NV_ARCH=arm64
        mkdir -p "$HOME/.local/bin"
        if curl -fL -o "$HOME/.local/bin/nvim" \
             "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NV_ARCH}.appimage"; then
          chmod +x "$HOME/.local/bin/nvim"
          "$HOME/.local/bin/nvim" --version >/dev/null 2>&1 \
            && ok "installed neovim AppImage → ~/.local/bin/nvim" \
            || warn "nvim AppImage needs FUSE — run: ~/.local/bin/nvim --appimage-extract, then symlink squashfs-root/usr/bin/nvim"
        else
          warn "neovim AppImage download failed — install manually: https://github.com/neovim/neovim/releases"
        fi
      fi
      # yq — Go binary (mikefarah/yq; the popular one, not the python yq)
      have yq || { have go && go install github.com/mikefarah/yq/v4@latest \
        || warn "install yq: go install github.com/mikefarah/yq/v4@latest"; }
      # ── kubectl / helm / terraform (parity with the Brewfile) ──
      mkdir -p "$HOME/.local/bin"
      if ! have kubectl; then
        K_ARCH=amd64; [ "$(uname -m)" = aarch64 ] && K_ARCH=arm64
        kver="$(curl -Ls https://dl.k8s.io/release/stable.txt)"
        curl -fLo "$HOME/.local/bin/kubectl" "https://dl.k8s.io/release/${kver}/bin/linux/${K_ARCH}/kubectl" \
          && chmod +x "$HOME/.local/bin/kubectl" && ok "installed kubectl ${kver}" \
          || warn "kubectl download failed"
      fi
      have helm || { curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
        || warn "helm install failed"; }
      if ! have terraform; then
        case "$PM" in
          apt)
            curl -fsSL https://apt.releases.hashicorp.com/gpg \
              | $SUDO gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg 2>/dev/null
            . /etc/os-release 2>/dev/null
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${VERSION_CODENAME:-stable} main" \
              | $SUDO tee /etc/apt/sources.list.d/hashicorp.list >/dev/null
            $SUDO apt-get update && $SUDO apt-get install -y terraform || warn "terraform apt install failed" ;;
          dnf|yum)
            $SUDO "$PM" install -y dnf-plugins-core 2>/dev/null
            $SUDO "$PM" config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo 2>/dev/null \
              || $SUDO "$PM" config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo 2>/dev/null
            $SUDO "$PM" install -y terraform || warn "terraform dnf install failed" ;;
          *) warn "terraform: install manually (unknown package manager)" ;;
        esac
      fi
      install_common_clones
    fi
    ;;

  *) err "unsupported OS: $(uname -s)"; exit 1 ;;
esac

ok "dependency install done."
[ "$MINIMAL" -eq 1 ] && log "Minimal set installed. Re-run without --minimal for the full stack."
