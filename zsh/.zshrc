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
plugins=(git colored-man-pages colorize pip python macos web-search sudo history zsh-autosuggestions zsh-syntax-highlighting copypath)

# Source scripts
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_custom_config/function.sh
source $HOME/.zsh_custom_config/alias.sh
source $HOME/.zsh_custom_config/temp.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$(pyenv root)/shims:$PATH"
export PYTHONPATH="/Users/sirutbuasai/.pyenv/versions/3.10.2/lib/python3.10/site-packages:$PYTHONPATH"
export PYTHONPATH="/Users/sirutbuasai/.pyenv/versions/3.9.10/lib/python3.9/site-packages:$PYTHONPATH"
export PYTHONPATH="/Users/sirutbuasai/Library/Python/3.9/lib/python/site-packages:$PYTHONPATH"
export PYTHONPATH="/opt/homebrew/lib/python3.9/site-packages:$PYTHONPATH"

# Others
eval "$(pyenv init -)"
