#!/usr/bin/env zsh

# homebrew — sets PATH, MANPATH, HOMEBREW_* (guarded: no-op on Linux/EC2 where brew is absent)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# rust / cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# uv
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# fzf
command -v fzf >/dev/null && eval "$(fzf --zsh)"
