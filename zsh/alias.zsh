#!/usr/bin/env zsh

# -- utils ----------------------------------------------------
alias clr='clear'
alias cln="find . -type f -name '*.DS_Store' -ls -delete"
alias cppath='copypath'          # OMZ copypath plugin
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

# -- git ------------------------------------------------------
alias got='git'
alias gir='git'
alias gti='git'

# -- languages ------------------------------------------------
alias cppc='c++ -std=c++11 -stdlib=libc++'
alias py='python'
alias py3='python3'

# -- nav ------------------------------------------------------
alias de='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias p='cd ~/personal_dev'

# -- quick links ----------------------------------------------
alias ghsb='open https://github.com/sirutBuasai'
alias drive='open https://drive.google.com'

# -- misc -----------------------------------------------------
alias gg='google'
alias ip4='curl -4 icanhazip.com'
alias ip6='curl -6 icanhazip.com'

# -- k8s ------------------------------------------------------
alias k='kubectl'

# -- tmux -----------------------------------------------------
alias tm='tmux'
alias tml='tmux ls'                                             # list sessions
tma() { [ -n "$1" ] && tmux attach -t "$1" || tmux attach; }    # attach (named, or most recent)
tmn() { tmux new -s "${1:-$(basename "$PWD")}"; }               # new session (named, or cwd basename)
tmk() { tmux kill-session -t "$1"; }                            # kill a named session
tms() { sesh connect "$(sesh list --icons | fzf --height 40% --reverse)"; }  # fuzzy project jump
