# Interactive shells only — bail out for scp/rsync/non-interactive.
case $- in
  *i*) ;;
    *) return ;;
esac

# ── History ──────────────────────────────────────────────────────────
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth:erasedups          # no dup/space-prefixed lines
HISTIGNORE='ls:ll:cd:pwd:clear:history:exit'
shopt -s histappend                        # append, don't overwrite
PROMPT_COMMAND='history -a'                # persist each command immediately

# ── Shell options ────────────────────────────────────────────────────
shopt -s checkwinsize                      # track terminal resize
shopt -s cdspell                           # autocorrect small cd typos
shopt -s globstar   2>/dev/null            # ** recursive glob (bash >= 4)
shopt -s autocd     2>/dev/null            # `dir` implies `cd dir` (bash >= 4)
shopt -s dirspell   2>/dev/null

# ── Editor ───────────────────────────────────────────────────────────
if command -v nvim >/dev/null 2>&1; then export EDITOR=nvim; else export EDITOR=vim; fi
export VISUAL="$EDITOR"

# ── Color ────────────────────────────────────────────────────────────
export CLICOLOR=1
if ls --color=auto >/dev/null 2>&1; then
  alias ls='ls --color=auto'               # GNU coreutils (Linux)
else
  alias ls='ls -G'                         # BSD ls (macOS)
fi
# `open` exists on macOS; alias to xdg-open on Linux when available.
if ! command -v open >/dev/null 2>&1 && command -v xdg-open >/dev/null 2>&1; then
  alias open='xdg-open'
fi

# ── Aliases ──────────────────────────────────────────────────────────
alias clr='clear'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias tc='touch'
alias py='python'
alias py3='python3'
alias diff='git diff --no-index'
command -v nvim >/dev/null 2>&1 && alias vim='nvim'

# git typo
alias got='git'
alias gir='git'
alias gti='git'

# navigation
[ -d "$HOME/personal_dev" ] && alias p='cd "$HOME/personal_dev"'
[ -d "$HOME/Downloads" ]    && alias dl='cd "$HOME/Downloads"'

# tmux helpers
alias tm='tmux'
alias tml='tmux ls'
tma() { [ -n "$1" ] && tmux attach -t "$1" || tmux attach; }   # attach named/most-recent
tmn() { tmux new -s "${1:-$(basename "$PWD")}"; }              # new named/cwd session
tmk() { tmux kill-session -t "$1"; }                           # kill named session

# -- Prompt status ----------------------------------------------------
__prompt_git() {
  local b
  b=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) \
    || b=$(git rev-parse --short HEAD 2>/dev/null) \
    || return
  local dirty=''
  git diff --quiet --ignore-submodules HEAD 2>/dev/null || dirty='*'
  printf ' (%s%s)' "$b" "$dirty"
}
__set_prompt() {
  local ec=$?
  local g; g=$(__prompt_git)
  local pchar
  [ "$ec" -eq 0 ] && pchar='\[\e[32m\]' || pchar='\[\e[31m\]'   # green ok / red fail
  PS1="\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\[\e[33m\]${g}\[\e[0m\]\n${pchar}\$\[\e[0m\] "
}
PROMPT_COMMAND="__set_prompt; $PROMPT_COMMAND"

# -- Tool init ---------------------------------------------------------
if   [ -x /opt/homebrew/bin/brew ];              then eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
[ -f "$HOME/.cargo/env" ]     && . "$HOME/.cargo/env"      # Rust
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"  # uv / pipx bin
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"        # smart cd (z/zi)
command -v fzf    >/dev/null 2>&1 && eval "$(fzf --bash)" 2>/dev/null  # C-r/C-t/M-c

# -- bash completion ---------------------------------------------------
if ! shopt -oq posix; then
  for f in /usr/share/bash-completion/bash_completion \
           /etc/bash_completion \
           /opt/homebrew/etc/profile.d/bash_completion.sh; do
    [ -r "$f" ] && { . "$f"; break; }
  done
fi

# -- Machine-local overrides -------------------------------------------
[ -f "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"

# keep this file's last command exit 0 so the first prompt renders green
:
