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

# Install everything in $HOME
cd $HOME/

# MacOS utils
log_info "Starting setup for new MacOS machine"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    xcode-developer-tools"
log_info "                    homebrew"
sudo xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
log_info "---------------------------------------------"

# Setup initial PATH
log_info "Setting preliminary binary path to .bash_profile"
log_info "---------------------------------------------"
log_info "PATH="/usr/local/bin:$PATH"" >> $HOME/bash_profile
source $HOME/bash_profile
log_info "---------------------------------------------"

# Setup all programming languages
log_info "Setting up programming languages"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    python"
log_info "                    node"
log_info "                    go"
log_info "                    rustup"
brew install python node go rustup
rustup-init
log_info "---------------------------------------------"

# Setup utility programs
log_info "Setting up utility programs"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    git"
log_info "                    tree"
log_info "                    fzf"
log_info "                    ripgrep"
log_info "                    yq"
log_info "                    jq"
log_info "                    bat"
log_info "                    glow"
brew install git tree fzf ripgrep bat yq jq bat glow
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
  brew install kubectl helm kustomize kind
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
# install zsh
brew install zsh
# install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended
rm -rf ${ZSH_CUSTOM:-$HOME/oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat
# install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# install neovim
brew install neovim
# Transfer configuraiton files
log_info "---------------------------------------------"
log_info "Configuration steps:"
log_info "                     .zshrc"
log_info "                     .p10k.zsh"
log_info "                     .gitconfig"
log_info "                     .vimrc"
log_info "                     .config/nvim"
# transfer zsh
cp -f $HOME/personal_dev/dotfiles/zsh/.zshrc $HOME/
mkdir -p $HOME/.zsh_custom
cp -rf $HOME/personal_dev/dotfiles/zsh/zsh_custom_config $HOME/.zsh_custom/
# transfer p10k
cp -f $HOME/personal_dev/dotfiles/zsh/.p10k.zsh $HOME/
# transfer git
cp -f $HOME/personal_dev/dotfiles/git/.gitconfig $HOME/
# transfer vim
cp -rf $HOME/personal_dev/dotfiles/vim/.vimrc $HOME/
# transfer neovim
mkdir -p $HOME/.config
cp -rf $HOME/personal_dev/dotfiles/nvim $HOME/.config/
# transfer tmux
rm -rf $HOME/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/tmux/plugins/tpm
cp -f $HOME/personal_dev/dotfiles/tmux/.tmux.conf $HOME/
log_info "---------------------------------------------"

# Setup kitty terminal
if kitty -v >/dev/null 2>&1; then
  log_info "Kitty terminal detected"
  log_info "---------------------------------------------"
  log_info "Configuration steps:"
  log_info "                     .config/kitty"
  cp -rf $HOME/personal_dev/dotfiles/kitty $HOME/.config/
  log_info "---------------------------------------------"
fi

# Restart shell
zsh -c "source ~/.zshrc"

# Setup python runtime
log_info "Setting up python runtime"
log_info "---------------------------------------------"
log_info "Installation steps:"
log_info "                    setuptools"
log_info "                    pip"
log_info "                    pynvim"
ln -s /opt/homebrew/bin/python3 /opt/homebrew/bin/python
ln -s /opt/homebrew/bin/pip3 /opt/homebrew/bin/pip
pip install --upgrade setuptools pip pynvim --break-system-packages
log_info "---------------------------------------------"

log_info "Setup is done!"
log_info "---------------------------------------------"
log_info "Post setup steps:"
log_info "1. Don't forget to restart your Kitty terminal"
log_info "2. Don't forget to download your applications!"
log_info "3. Don't forget to download your fonts!"
log_info "---------------------------------------------"
