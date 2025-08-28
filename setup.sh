#!/usr/bin/env bash
# Usage: bash setup.sh [--no-kubernetes]

# ======================
# Utility functions
# ======================
function print_usage() {
  echo "Usage:"
  echo "bash setup.sh --include-k8s [OPTIONAL][FLAG]"
}

function log_info() {
  echo "[INFO]: ${1}"
}

function log_error() {
  echo "[ERROR]: ${1}"
}

function detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  elif command -v apt-get &>/dev/null; then
    echo "ubuntu"
  else
    log_error "Unsupported operating system"
    exit 1
  fi
}

# ======================
# Path Resolution
# ======================
function get_script_dir() {
  # Get the directory where setup.sh lives
  # Works with both symlinks and direct execution
  dirname "$(readlink -f "${BASH_SOURCE[0]}")"
}

# ======================
# Package Manager Functions
# ======================
function install_packages() {
  local os=$1
  shift
  local packages=("$@")

  case $os in
    macos)
      brew install "${packages[@]}"
      ;;
    ubuntu)
      sudo apt-get update
      sudo apt-get install -y "${packages[@]}"
      ;;
  esac
}

function setup_package_manager() {
  local os=$1

  case $os in
    macos)
      # Install Homebrew
      if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        brew update
      fi
      ;;
    ubuntu)
      # Update apt
      sudo apt-get update
      sudo apt-get install -y curl wget git
      ;;
  esac
}

# ======================
# Arguments handling
# ======================
while [[ $# -gt 0 ]]; do
  case "${1}" in
    -k|--include-k8s) shift; INSTALL_KUBE=1
    ;;
    *) log_error "Bad argument ${1}"; print_usage; exit 1
    ;;
  esac
done

# Get the dotfiles directory path
log_info "---------------------------------------------"
DOTFILES_DIR=$(get_script_dir)
log_info "Dotfiles directory: $DOTFILES_DIR"
# Detect OS
OS=$(detect_os)
log_info "Detected OS: $OS"
log_info "---------------------------------------------"

# Set up paths
cd $HOME/
# Setup package manager
setup_package_manager $OS

# MacOS-specific setup
if [[ "$OS" == "macos" ]]; then
  log_info "Installing xcode developer tools..."
  sudo xcode-select --install || true
fi
log_info "---------------------------------------------"

# Setup initial PATH
log_info "Setting preliminary binary path to .bash_profile"
log_info "---------------------------------------------"
echo 'export PATH="/usr/local/bin:$PATH"' >> $HOME/.bash_profile
sh -c ". $HOME/.bash_profile"
log_info "---------------------------------------------"

# Setup all programming languages
log_info "Setting up programming languages"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    python"
log_info "                    node"
log_info "                    go"
log_info "                    rust"

case $OS in
  macos)
    install_packages $OS python node go rustup
    rustup-init -y
    ;;
  ubuntu)
    # Add Node.js repository
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    # Add Go repository
    sudo add-apt-repository -y ppa:longsleep/golang-backports
    install_packages $OS python3 python3-pip nodejs golang rustc cargo
    ;;
esac
log_info "---------------------------------------------"

# Setup utility programs
log_info "Setting up utility programs"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    git"
log_info "                    tree"
log_info "                    fzf"
log_info "                    ripgrep"
log_info "                    bat"
log_info "                    fd"
log_info "                    jq"
log_info "                    yq"

case $OS in
  macos)
    install_packages $OS git tree fzf ripgrep bat fd yq jq
    ;;
  ubuntu)
    install_packages $OS git tree fzf ripgrep bat fd-find
    # Install yq
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
    sudo chmod +x /usr/bin/yq
    # Install jq
    install_packages $OS jq
    ;;
esac
log_info "---------------------------------------------"

# Setup Kubernetes if flag provided
if [[ "${INSTALL_KUBE}" -eq 1 ]]; then
  log_info "K8s flag provided, setting up k8s utility programs"
  log_info "---------------------------------------------"
  log_info "Installation steps:"
  log_info "                    kubectl"
  log_info "                    helm"
  log_info "                    kustomize"
  log_info "                    kind"

  case $OS in
    macos)
      install_packages $OS kubectl helm kustomize kind
      ;;
    ubuntu)
      # Install kubectl
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
      rm kubectl
      # Install helm
      curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
      # Install kustomize
      curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
      sudo mv kustomize /usr/local/bin/
      # Install kind
      curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
      sudo install -o root -g root -m 0755 kind /usr/local/bin/kind
      rm kind
      ;;
  esac
else
  log_info "K8s flag not provided, skipping k8s utility programs"
fi
log_info "---------------------------------------------"

# Setup core developer environment
log_info "Setting up core developer environment"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    zsh"
log_info "                    oh-my-zsh"
log_info "                    powerlevel10k"
log_info "                    neovim"

# Install zsh and neovim
case $OS in
  macos)
    install_packages $OS zsh neovim
    ;;
  ubuntu)
    install_packages $OS zsh
    # Install neovim from PPA
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update
    install_packages $OS neovim
    ;;
esac

# install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting || true
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat || true
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab || true

# install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Transfer configuration files
log_info "---------------------------------------------"
log_info "Configuration steps:"
log_info "                     .zshrc"
log_info "                     .p10k.zsh"
log_info "                     .gitconfig"
log_info "                     .vimrc"
# transfer zsh
cp -f "$DOTFILES_DIR/zsh/.zshrc" "$HOME/"
mkdir -p $HOME/.zsh_custom
cp -rf "$DOTFILES_DIR/zsh/zsh_custom_config/." "$HOME/.zsh_custom/"
# transfer p10k
cp -f "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/"
# transfer git
cp -f "$DOTFILES_DIR/git/.gitconfig" "$HOME/"
# transfer vim
cp -rf "$DOTFILES_DIR/vim/.vimrc" "$HOME/"
# transfer neovim
mkdir -p $HOME/.config
cp -rf "$DOTFILES_DIR/nvim" "$HOME/.config/"
# transfer tmux
rm -rf $HOME/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/tmux/plugins/tpm
cp -f "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/"
log_info "---------------------------------------------"

# Setup kitty terminal
if kitty -v >/dev/null 2>&1; then
  log_info "Kitty terminal detected"
  log_info "---------------------------------------------"
  log_info "Configuration steps:"
  log_info "                     .config/kitty"
  cp -rf "$DOTFILES_DIR/kitty" "$HOME/.config/"
  log_info "---------------------------------------------"
fi

# Restart shell
sh -c ". $HOME/.zshrc"

# Setup python runtime
log_info "Setting up python runtime"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    setuptools"
log_info "                    pip"
log_info "                    pynvim"
log_info "                    pyenv"
log_info "                    pyenv-virtualenv"
log_info "                    uv"

case $OS in
  macos)
    ln -s /opt/homebrew/bin/python3 /opt/homebrew/bin/python || true
    ln -s /opt/homebrew/bin/pip3 /opt/homebrew/bin/pip || true
    pip install --upgrade setuptools pip pynvim --break-system-packages
    brew install pyenv openssl readline sqlite3 xz zlib tcl-tk@8 libb2 pyenv-virtualenv
    ;;
  ubuntu)
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
      libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
      libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    pip3 install --upgrade setuptools pip pynvim --break-system-packages
    curl https://pyenv.run | bash
    ;;
esac
curl -LsSf https://astral.sh/uv/install.sh | sh
log_info "---------------------------------------------"

# Setup neovim related dependencies
log_info "Setting up neovim plugin dependencies"
log_info "---------------------------------------------"
log_info "Installation steps:"
git clone https://github.com/shreyas-a-s/shell-color-scripts.git
cd shell-color-scripts
sudo make install
log_info "---------------------------------------------"

log_info "Setup is done!"
log_info "---------------------------------------------"
log_info "Post setup steps:"
log_info "1. Don't forget to restart your Kitty terminal"
log_info "2. Don't forget to download your applications!"
log_info "3. Don't forget to download your fonts!"
log_info "---------------------------------------------"
