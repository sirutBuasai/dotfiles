alias zon='cd /fsx/workplace'
alias p='cd /fsx/personal_dev'

# export PATH=$PATH:/Users/sbuasai/.toolbox/bin
# source /Users/sbuasai/.brazil_completion/zsh_completion

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/sbuasai/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/sbuasai/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/sbuasai/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/sbuasai/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

complete -d cd

function upaws(){
  if [[ $# -gt 0 ]]; then
    while [[ $# -gt 0 ]]; do
      case "$1" in
        git) shift;
          echo "Updating Git"
          rsync -avh ~/.gitconfig /fsx/personal_dev/dotfiles/git/.gitconfig --delete
        ;;
        zsh) shift;
          echo "Updating Zsh"
          rsync -avh ~/.bashrc /fsx/personal_dev/dotfiles/zsh/.bashrc --delete
          rsync -avh ~/.zsh_custom/ /fsx/personal_dev/dotfiles/zsh/zsh_custom_config/ --delete
        ;;
        nvim) shift;
          echo "Updating Nvim"
          rsync -avh --exclude 'autoload' ~/.config/nvim/ /fsx/personal_dev/dotfiles/nvim/ --delete
        ;;
        *) shift;
          echo "Invalid Update"
        ;;
      esac
    done
  else
    echo "Updating All"
    rsync -avh ~/.gitconfig /fsx/personal_dev/dotfiles/git/.gitconfig --delete
    rsync -avh ~/.bashrc /fsx/personal_dev/dotfiles/zsh/.bashrc --delete
    rsync -avh ~/.zsh_custom/ /fsx/personal_dev/dotfiles/zsh/zsh_custom_config/ --delete
    rsync -avh --exclude 'autoload' ~/.config/nvim/ /fsx/personal_dev/dotfiles/nvim/ --delete
  fi
  cd /fsx/personal_dev/dotfiles/

  aws s3 sync --delete /fsx/personal_dev/dotfiles/ s3://sbuasai-dev/personal_dev/dotfiles/
}
