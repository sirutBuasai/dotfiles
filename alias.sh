#!/usr/bin/env sh
# ─────────────────────────────────────────────────────────────
# alias.sh — v2 shell aliases (STAGING for the L3 shell layer)
# Collected as we build each layer so L3 can just `source alias.sh`
# (or fold it into the chezmoi-managed ~/.zsh_custom/).
# ─────────────────────────────────────────────────────────────

# ── tmux (L2) ────────────────────────────────────────────────
# tma [name]  attach to a named session, or the most recent if omitted
tma() { if [ -n "$1" ]; then tmux attach -t "$1"; else tmux attach; fi; }

# tmn [name]  new session named after arg, or the current dir's basename
tmn() { tmux new -s "${1:-$(basename "$PWD")}"; }

# tml         list sessions
alias tml='tmux ls'

# tmk <name>  kill a named session
tmk() { tmux kill-session -t "$1"; }

# tms         fuzzy jump to / create a project session (requires: sesh, fzf)
tms() { sesh connect "$(sesh list --icons | fzf --height 40% --reverse)"; }
