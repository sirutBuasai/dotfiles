alias zon='cd ~/workplace'
alias ackdir='cd ~/go/src/github.com/aws-controllers-k8s'
alias cdk="npx aws-cdk"
alias dlc='open https://github.com/sirutBuasai/deep-learning-containers'
alias pdlc='open https://github.com/sirutBuasai/PRIVATE-deep-learning-containers'
alias awsdlc='open https://github.com/aws/deep-learning-containers'
alias pawsdlc='open https://github.com/aws/PRIVATE-deep-learning-containers'
alias dlami='open https://github.com/sirutBuasai/deep-learning-amis'
alias awsdlami='open https://github.com/aws/deep-learning-amis'
alias ack='open https://github.com/sirutBuasai/sagemaker-controller'
alias awsack='open https://github.com/aws-controllers-k8s/sagemaker-controller'

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
source /Users/sbuasai/.brazil_completion/zsh_completion

eval "$(/opt/homebrew/bin/brew shellenv)"
# Set up mise for runtime management
eval "$(mise activate zsh)"

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
