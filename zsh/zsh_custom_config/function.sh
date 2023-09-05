## Open link start https:// prefix -----------------------------------------------------------------
function ol() {
  if [[ ! -z "${1}" ]]; then
    input="${1}"

    open 'https://'"${input}"

  else
    >&2 echo 'Error: No website given'

  fi
}


## Open application on the computer ----------------------------------------------------------------
function oa() {
  if [[ ! -z "${1}" ]]; then
    input="${1}"

    ## Add your application aliases here
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


## Search on youtube -------------------------------------------------------------------------------
function yt() {
  if [[ ! -z "${*}" ]]; then
    local IFS=+
    input="${*}"
    open 'http://www.youtube.com/results?search_query='"${input}"

  else
    open 'https://youtube.com'

  fi
}


## Fizzy find directory ----------------------------------------------------------------------------
function fzd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}


## Fuzzy find command history ----------------------------------------------------------------------
function fzh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}


## Update all dotfiles onto git repo ---------------------------------------------------------------
function upd(){
  if [[ $# -gt 0 ]]; then
    while [[ $# -gt 0 ]]; do
      case "$1" in
        git) shift;
          echo "Updating Git"
          rsync -avh ~/.gitconfig ~/personal_dev/dotfiles/git/.gitconfig --delete
        ;;
        ssh) shift;
          echo "Updating Ssh"
          rsync -avh ~/.ssh/config ~/personal_dev/dotfiles/ssh/config --delete
        ;;
        zsh) shift;
          echo "Updating Zsh"
          rsync -avh ~/.p10k.zsh ~/personal_dev/dotfiles/zsh/.p10k.zsh --delete
          rsync -avh ~/.zshrc ~/personal_dev/dotfiles/zsh/.zshrc --delete
          rsync -avh ~/.zsh_custom/ ~/personal_dev/dotfiles/zsh/zsh_custom_config/ --delete
        ;;
        nvim) shift;
          echo "Updating Nvim"
          rsync -avh --exclude 'autoload' ~/.config/nvim/ ~/personal_dev/dotfiles/nvim/ --delete
        ;;
        *) shift;
          echo "Invalid Update"
        ;;
      esac
    done
  else
    echo "Updating All"
    rsync -avh ~/.gitconfig ~/personal_dev/dotfiles/git/.gitconfig --delete
    rsync -avh ~/.ssh/config ~/personal_dev/dotfiles/ssh/config --delete
    rsync -avh ~/.p10k.zsh ~/personal_dev/dotfiles/zsh/.p10k.zsh --delete
    rsync -avh ~/.zshrc ~/personal_dev/dotfiles/zsh/.zshrc --delete
    rsync -avh ~/.zsh_custom/ ~/personal_dev/dotfiles/zsh/zsh_custom_config/ --delete
    rsync -avh --exclude 'autoload' ~/.config/nvim/ ~/personal_dev/dotfiles/nvim/ --delete
  fi
  cd ~/personal_dev/dotfiles/
}


## Make a directory and cd into the new directory --------------------------------------------------
function mkcd() {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"

  elif [ -d $1 ]; then
    echo "\`$1' already exists"

  else
    mkdir $1 && cd $1

  fi
}
