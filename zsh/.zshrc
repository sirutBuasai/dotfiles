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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration ------------------------------------------------------------------------------
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$(pyenv root)/shims:$PATH"
export PYTHONPATH="/Users/sirutbuasai/.pyenv/versions/3.10.2/lib/python3.10/site-packages:$PYTHONPATH"
export PYTHONPATH="/Users/sirutbuasai/Library/Python/3.9/lib/python/site-packages:$PYTHONPATH"
export PYTHONPATH="/opt/homebrew/lib/python3.9/site-packages:$PYTHONPATH"

# User functions ----------------------------------------------------------------------------------
## Open link start https:// prefix
function ol() {
  if [[ ! -z "${1}" ]]; then
    input="${1}"
    open 'https://'"${input}"
  else
    >&2 echo 'Error: No website given'
  fi
}

## Open application on the computer
function oa() {
  if [[ ! -z "${1}" ]]; then
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

## Open a set of default applications
function startup() {
  # Add your default applications here
  default=('spotify' 'todoist' 'notion' 'outlook')

  for app in ${default}; do
    oa "${app}"
  done
}

## Fizzy find directory
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

## Fuzzy find command history
function fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

## Update all dotfiles onto git repo
function upd(){
  rsync -avh ~/.gitconfig ~/personal_dev/dotfiles/git/.gitconfig --delete
  rsync -avh ~/.ssh/config ~/personal_dev/dotfiles/ssh/config --delete
  rsync -avh ~/.zshrc ~/personal_dev/dotfiles/zsh/.zshrc --delete
  rsync -avh --exclude 'autoload' ~/.config/nvim/ ~/personal_dev/dotfiles/nvim/ --delete
  cd ~/personal_dev/dotfiles/
}

## Make a directory and cd into the new directory
function mkcd() {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

# Aliases -----------------------------------------------------------------------------------------
# Utilities
alias clr='clear'
alias cln="find . -type f -name '*.DS_Store' -ls -delete"
alias cppath='copypath'
alias grep='grep --color=auto'
alias ut='uptime'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ll='ls -lah'
alias mkdir='mkdir -pv'
alias tc='touch'
alias vim='nvim'
alias diff='git diff --no-index'

# Git typos
alias gir='git'
alias gti='git'

# Language compilation
alias cppc='c++ -std=c++11 -stdlib=libc++'
alias py3='python3'
alias py3test='python3 -m unittest'

# Change dir
alias de='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias p='cd ~/personal_dev'

# Others
alias gg='google'
alias ip4='curl -4 icanhazip.com'
alias ip6='curl -6 icanhazip.com'

# Others ------------------------------------------------------------------------------------------
eval "$(pyenv init -)"
