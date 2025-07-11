export BRAZIL_WORKSPACE_DEFAULT_LAYOUT=short

export AUTO_TITLE_SCREENS="NO"

# if you wish to use IMDS set AWS_EC2_METADATA_DISABLED=false
export AWS_EC2_METADATA_DISABLED=true

export PROMPT="
%{$fg[white]%}(%D %*) <%?> [%~] $program %{$fg[default]%}
%{$fg[cyan]%}%m %#%{$fg[default]%} "

export RPROMPT=

set-title() {
    echo -e "\e]0;$*\007"
}

ssh() {
    set-title $*;
    /usr/bin/ssh -2 $*;
    set-title $HOST;
}

alias e=emacs
alias bb=brazil-build

alias bba='brazil-build apollo-pkg'
alias bre='brazil-runtime-exec'
alias brc='brazil-recursive-cmd'
alias bws='brazil ws'
alias bwsuse='bws use -p'
alias bwscreate='bws create -n'
alias brc=brazil-recursive-cmd
alias bbr='brc brazil-build'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'
alias bbra='bbr apollo-pkg'


export PATH=$HOME/.toolbox/bin:$PATH
autoload -Uz compinit && compinit

# Set up mise for runtime management
eval "$(/home/sbuasai/.local/bin/mise activate zsh)"
source ~/.local/share/mise/completions.zsh

# Set up mise for runtime management
eval "$(/home/sbuasai/.local/bin/mise activate zsh)"
source ~/.local/share/mise/completions.zsh

# Set up mise for runtime management
eval "$(/home/sbuasai/.local/bin/mise activate zsh)"
source ~/.local/share/mise/completions.zsh
source /home/sbuasai/.brazil_completion/zsh_completion
alias finch='sudo HOME=/home/sbuasai DOCKER_CONFIG=/home/sbuasai/.docker finch'

# Set up go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/go/bin"

# Set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source personal zsh
source ~/.zshrc_personal
