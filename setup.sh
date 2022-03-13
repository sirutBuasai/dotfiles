#!/usr/bin/env bash
#### THIS SCRIPT IS INCOMPLETE. TESTING NEEDED!!!! ####
curr_dir="$(pwd)"

echo 'Installing xcode developer tools'
sudo xcode-select --install

echo 'Setting path to .bash_profile'
echo 'PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

echo 'Installing iterm2'
brew install --cask iterm2

echo 'Installing zsh'
brew install zsh

echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo 'Installing other useful programs'
brew install tree
brew install git

echo 'Transferring custom config files'

echo 'Installing powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo 'Setup is done!'
echo 'Todo: ---------------------------------------------------------'
echo '1. Dont forget to setup iterm2 preferences!'
echo '2. Dont forget to download your applications!'

