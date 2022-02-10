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
plugins=(git colored-man-pages colorize pip python brew macos web-search sudo history zsh-autosuggestions zsh-syntax-highlighting)

# Source scripts
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration
export PATH="/usr/local/share/python:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
#export PYTHONPATH="/Users/sirutbuasai/.pyenv/versions/3.10.2/lib/python3.10/site-packages

# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'
alias rm='rm -i'
alias ll='ls -la'
alias clr='clear'
alias ip4='curl -4 icanhazip.com'
alias ip6='curl -6 icanhazip.com'
alias o='open .'
alias ut='uptime'
alias tc='touch'
alias gg='google'
alias fd*='find . -type d -name'
alias ff='find . -type f -name'

# Othersv
eval "$(pyenv init -)"
