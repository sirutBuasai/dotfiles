alias mqp='cd ~/personal_dev/advanced_gen_modeling_mqp_2022_2023'
alias zon='cd ~/workplace'
alias cdk="npx aws-cdk"

# brazil aliases
alias bb='brazil-build'
alias bba='brazil-build apollo-pkg'
alias bre='brazil-runtime-exec'
alias brc='brazil-recursive-cmd'
alias bws='brazil ws'
alias bwsuse='bws use --gitMode -p'
alias bwscreate='bws create -n'
alias brc='brazil-recursive-cmd'
alias bbr='brc brazil-build'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'
alias bbra='bbr apollo-pkg'

export PATH=$PATH:/Users/sbuasai/.toolbox/bin
export PATH="$HOME/.rbenv/versions/2.7.8/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
source /Users/sbuasai/.brazil_completion/zsh_completion

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/sbuasai/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/sbuasai/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/sbuasai/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/sbuasai/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/sbuasai/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/sbuasai/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
