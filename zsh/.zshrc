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
plugins=(git colored-man-pages colorize pip python macos web-search sudo history zsh-autosuggestions zsh-syntax-highlighting)

# Source scripts
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration
export PATH="/usr/local/share/python:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
#export PYTHONPATH="/Users/sirutbuasai/.pyenv/versions/3.10.2/lib/python3.10/site-packages

# User functions
## Open link start https:// prefix
function ol() {
  if [[ ! -z "${1}" ]] then
    input="${1}"
    open 'https://'"${input}"
  else
    >&2 echo 'Error: No website given'
  fi
}

## Open application on the computer
function oa() {
  if [[ ! -z "${1}" ]] then
    input="${1}"

    ## Add your applicaiton aliases here
    declare -A app_map=( ['chrome']='google chrome'
                         ['outlook']='microsoft outlook'
                         ['tor']='tor browser'
                         ['zoom']='zoom.us'
                         ['sys']='system preferences'
                         ['pb']='photo booth'
                         ['store']='app store'
                         ['act']='activity monitor'
                       )

    open -a "${app_map[${input}]:=${input}}"

  else
    >&2 echo 'Error: No application given'
  fi
}

# Aliases
alias cppc='c++ -std=c++11 -stdlib=libc++'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ll='ls -la'
alias clr='clear'
alias ip4='curl -4 icanhazip.com'
alias ip6='curl -6 icanhazip.com'
alias ut='uptime'
alias tc='touch'
alias gg='google'
alias p='cd ~/Personal\ Codes/'
alias de='cd ~/Desktop/'
alias mkdir='mkdir -pv'
alias weather='curl http://wttr.in/\?m'

# Others
eval "$(pyenv init -)"

