#!/usr/bin/env bash

cd $HOME

# setup git
cp -f $HOME/dotfiles/git/.gitconfig $HOME

# setup vim
cp -f $HOME/dotfiles/vim/.vimrc $HOME

# setup tmux
sudo apt install tmux
rm -rf $HOME/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/tmux/plugins/tpm
cp -f $HOME/dotfiles/tmux/.tmux.conf $HOME

# setup conda/mamba
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh

# setup shell
wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O oh-my-bash-install.sh
bash -c "$(< oh-my-bash-install.sh)" --unattended
cp -f $HOME/dotfiles/aws/.bashrc $HOME
