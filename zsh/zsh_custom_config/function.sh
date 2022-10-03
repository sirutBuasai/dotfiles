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
                         ['camera']='photo booth'
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
  rsync -avh ~/.p10k.zsh ~/personal_dev/dotfiles/zsh/.p10k.zsh --delete
  rsync -avh ~/.zshrc ~/personal_dev/dotfiles/zsh/.zshrc --delete
  rsync -avh ~/.zsh_custom/ ~/personal_dev/dotfiles/zsh/zsh_custom_config/ --delete
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