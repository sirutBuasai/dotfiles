#!/usr/bin/env bash
#### THIS SCRIPT IS INCOMPLETE. TESTING NEEDED!!!! ####
cd $HOME/

echo 'Installing xcode developer tools'
sudo xcode-select --install

echo 'Installing homebrew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update

echo 'Setting path to .bash_profile'
echo 'PATH="/usr/local/bin:$PATH"' >> $HOME/bash_profile

echo 'Installing python'
brew install python

echo 'Installing node'
brew install node

echo 'Installing rust'
brew install rustup
rustup-init

echo 'Installing zsh'
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended
rm -rf ${ZSH_CUSTOM:-$HOME/oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-$HOME/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo 'Installing powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo 'Installing neovim'
brew install neovim

echo 'Installing other useful programs'
brew install tree
brew install git
brew install fzf
brew install ripgrep

echo 'Transferring custom config files'
echo 'Transferring zsh'
cp -f $HOME/personal_dev/dotfiles/zsh/.zshrc $HOME/
cp -f $HOME/personal_dev/dotfiles/zsh/zsh_custom_config/* $HOME/.zsh_custom/

echo 'Transferring zsh'
cp -f $HOME/personal_dev/dotfiles/git/.gitconfig $HOME/

echo 'Transferring neovim'
mkdir -p $HOME/config
cp -rf $HOME/personal_dev/dotfiles/nvim $HOME/config/

echo 'Transferggin tmux'
rm -rf $HOME/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/tmux/plugins/tpm
cp -f $HOME/personal_dev/dotfiles/tmux/.tmux.conf $HOME/

echo 'Installing python packages'
pip install --upgrade setuptools
pip install --upgrade pip
pip install --upgrade pynvim --break-system-packages
echo 'Setup is done!'
echo 'Todo: ---------------------------------------------------------'
echo '1. Dont forget to setup iterm2 preferences!'
echo '2. Dont forget to download your applications!'
