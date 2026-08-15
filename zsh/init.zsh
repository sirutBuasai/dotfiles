#!/usr/bin/env zsh

# homebrew — sets PATH, MANPATH, HOMEBREW_*
eval "$(/opt/homebrew/bin/brew shellenv)"

# rust / cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# uv
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# fzf
command -v fzf >/dev/null && eval "$(fzf --zsh)"
