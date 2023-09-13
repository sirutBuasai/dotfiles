#!/usr/bin/env bash

# setup shell
cd ~
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
cp -f /fsx/personal_dev/dotfiles/aws/.bashrc ~

# setup git
cp -f /fsx/personal_dev/dotfiles/git/.gitconfig ~

# setup neovim
sudo snap install --beta nvim --classic
sudo apt update
sudo apt install nodejs
sudo apt install npm
mkdir -p ~/.config
cp -rf /fsx/personal_dev/dotfiles/nvim ~/.config/

# setup tmux
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp -f /fsx/personal_dev/dotfiles/tmux/.tmux.conf ~
