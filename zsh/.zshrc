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
plugins=(
  colored-man-pages
  colorize
  copybuffer
  copyfile
  copypath
  git
  history
  macos
  pip
  python
  sudo
  web-search
  zsh-autosuggestions
  zsh-bat
  zsh-syntax-highlighting
)

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
export PYTHONPATH="/Users/sirutbuasai/.pyenv/versions/3.10.7/lib/python3.10/site-packages:$PYTHONPATH"
export PYTHONPATH="/Users/sirutbuasai/.pyenv/versions/3.9.14/lib/python3.9/site-packages:$PYTHONPATH"
export PYTHONPATH="/Users/sirutbuasai/Library/Python/3.9/lib/python/site-packages:$PYTHONPATH"
export PYTHONPATH="/opt/homebrew/lib/python3.9/site-packages:$PYTHONPATH"

# pyenv Initialization
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Vim keys in terminal
bindkey -v
