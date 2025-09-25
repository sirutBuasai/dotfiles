# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme name
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(aws
  brew
  colored-man-pages
  colorize
  copybuffer
  copyfile
  copypath
  fast-syntax-highlighting
  fzf-tab
  git
  golang
  helm
  history
  kubectl
  macos
  pip
  pyenv
  python
  sudo
  vi-mode
  web-search
  zsh-autosuggestions
  zsh-bat
  zsh-syntax-highlighting)

# Source scripts
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_custom/function.sh
source $HOME/.zsh_custom/alias.sh
source $HOME/.zsh_custom/temp.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Go configuration
export GOPATH="$HOME/go" # You can change this to whatever you GOPATH was in the previous step
export GOBIN="$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

. "$HOME/.local/bin/env"
