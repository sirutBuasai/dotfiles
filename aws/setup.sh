#!/usr/bin/env bash
# Usage: bash aws_setup.sh [--include-k8s]

# ======================
# Utility functions
# ======================
function print_usage() {
  echo "Usage:"
  echo "bash aws_setup.sh --include-k8s [OPTIONAL][FLAG]"
}

function log_info() {
  echo "[INFO]: ${1}"
}

function log_error() {
  echo "[ERROR]: ${1}"
}

function get_script_dir() {
  # Get the directory where setup.sh lives
  # Works with both symlinks and direct execution
  dirname "$(readlink -f "${BASH_SOURCE[0]}")"
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
log_info "---------------------------------------------"

# Set up paths
cd $HOME/

# Set up builder tools
toolbox install axe
sh -c ". ~/.zshrc"
axe init builder-tools
sh -c ". ~/.zshrc"

# Initial system update
log_info "Updating system packages"
sudo yum update -y
sudo yum install -y curl wget git

# Setup all programming languages
log_info "Setting up programming languages"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    nodejs"
log_info "                    python"
log_info "                    go"
log_info "                    rustup"

# Install nodejs
mise use -g node@lts node@22 node@20 node@18

# Install python
mise use -g python@3.12 python@3.11 python@3.10 python@3.9 python@3.8

# Install go
GO_VERSION="1.24.5"
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf $HOME/go
sudo tar -C $HOME -xzf go$GO_VERSION.linux-amd64.tar.gz

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

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

# Install tree
sudo yum install -y tree

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all

# Install ripgrep
cargo install ripgrep

# Install bat
cargo install bat

# Install fd-find
cargo install fd-find

# Install yq
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
sudo chmod +x /usr/bin/yq

# Install jq
sudo yum install -y jq

# Setup Kubernetes if flag provided
if [[ "${INSTALL_KUBE}" -eq 1 ]]; then
  log_info "K8s flag provided, setting up k8s utility programs"
  log_info "---------------------------------------------"
  log_info "Installation steps:"
  log_info "                    kubectl"
  log_info "                    helm"
  log_info "                    kustomize"
  log_info "                    kind"

  # Install kubectl
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo chmod +x kubectl
  sudo mv kubectl /usr/bin/kubectl

  # Install helm
  curl "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3" | bash 1>/dev/null

  # Install kustomize
  KUSTOMIZE_VERSION="5.7.9"
  wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz
  sudo tar -C /usr/bin -zxvf kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz
  sudo chmod +x /usr/bin/kustomize

  # Install kind
  # # For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
  chmod +x ./kind
  sudo mv ./kind /usr/bin/kind
fi

# Setup core developer environment
log_info "Setting up core developer environment"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    zsh"
log_info "                    oh-my-zsh"
log_info "                    powerlevel10k"
log_info "                    neovim"

# Install zsh
sudo yum install -y zsh

# Install neovim
NEOVIM_VERSION="0.11.2"
sudo yum install cmake3
git clone https://github.com/neovim/neovim.git && pushd neovim
git checkout v${NEOVIM_VERSION}
make CMAKE_BUILD_TYPE=Release
sudo make install
popd


# Install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting || true
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat || true
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab || true

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Transfer configuration files
log_info "---------------------------------------------"
log_info "Configuration steps:"
log_info "                     .zshrc"
log_info "                     .p10k.zsh"
log_info "                     .gitconfig"
log_info "                     .vimrc"

# Transfer zsh config
cp -f "$DOTFILES_DIR/aws/.zshrc" "$HOME/"
cp -f "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc_personal"
mkdir -p $HOME/.zsh_custom
cp -rf "$DOTFILES_DIR/zsh/zsh_custom_config/." "$HOME/.zsh_custom/"

# Transfer p10k config
cp -f "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/"

# Transfer git config
cp -f "$DOTFILES_DIR/git/.gitconfig" "$HOME/"

# Transfer vim config
cp -rf "$DOTFILES_DIR/vim/.vimrc" "$HOME/"

# Transfer neovim config
mkdir -p $HOME/.config
cp -rf "$DOTFILES_DIR/nvim" "$HOME/.config/"

# Transfer tmux config
rm -rf $HOME/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/tmux/plugins/tpm
cp -f "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/"

# Setup python runtime
log_info "Setting up python runtime"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    setuptools"
log_info "                    pip"
log_info "                    pynvim"
log_info "                    pyenv"
log_info "                    pyenv-virtualenv"

# Install Python development tools
sudo yum install -y \
  gcc \
  make \
  patch z\
  lib-devel \
  bzip2 \
  bzip2-devel \
  readline-devel \
  sqlite \
  sqlite-devel \
  openssl11-devel \
  tk-devel \
  libffi-devel \
  xz-devel

# Install Python packages
pip3 install --upgrade setuptools pip pynvim --break-system-packages

# Install pyenv
curl https://pyenv.run | bash

# Setup neovim related dependencies
log_info "Setting up neovim plugin dependencies"
log_info "---------------------------------------------"
log_info "Installation steps:"
git clone https://github.com/shreyas-a-s/shell-color-scripts.git
cd shell-color-scripts
sudo make install
cd ..
rm -rf shell-color-scripts

log_info "Setup is done!"
log_info "---------------------------------------------"
log_info "Post setup steps:"
log_info "1. Change your default shell to zsh: chsh -s $(which zsh)"
log_info "2. Add pyenv to your path by adding these to your .zshrc:"
log_info "   export PYENV_ROOT=\"\$HOME/.pyenv\""
log_info "   command -v pyenv >/dev/null || export PATH=\"\$PYENV_ROOT/bin:\$PATH\""
log_info "   eval \"\$(pyenv init -)\""
log_info "3. Restart your shell"
log_info "---------------------------------------------"
