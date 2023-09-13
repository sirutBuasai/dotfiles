#!/usr/bin/env bash
#### THIS SCRIPT IS INCOMPLETE. TESTING NEEDED!!!! ####
cd ~

echo 'Installing xcode developer tools'
sudo xcode-select --install

echo 'Installing homebrew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update

echo 'Setting path to .bash_profile'
echo 'PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

echo 'Installing python'
brew install python
pip install --upgrade setuptools
pip install --upgrade pip

echo 'Installing node'
brew install node

echo 'Installing rust'
brew install rustup
rustup-init

echo 'Installing iterm2'
brew install --cask iterm2

echo 'Installing zsh'
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo 'Installing powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo 'Installing neovim'
brew install neovim
python3 -m pip install pynvim

echo 'Installing other useful programs'
brew install tree
brew install git
brew install fzf
brew install ripgrep

echo 'Transferring custom config files'
echo 'Transferring zsh'
cp -f ~/personal_dev/dotfiles/zsh/.zshrc ~

echo 'Transferring zsh'
cp -f ~/personal_dev/dotfiles/git/.gitconfig ~
cp -f /fsx/personal_dev/dotfiles/git/.gitconfig ~

echo 'Transferring neovim'
mkdir -p ~/.config
cp -rf ~/personal_dev/dotfiles/nvim ~/.config/

echo 'Transferggin tmux'
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp -f ~/personal_dev/dotfiles/tmux/.tmux.conf ~

echo 'Setup is done!'
echo 'Todo: ---------------------------------------------------------'
echo '1. Dont forget to setup iterm2 preferences!'
echo '2. Dont forget to download your applications!'
