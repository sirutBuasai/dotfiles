#!/usr/bin/env zsh
# ─────────────────────────────────────────────────────────────
# init.zsh — binary / tool initialization (sourced AFTER path.zsh,
#            BEFORE oh-my-zsh so plugins find the binaries)
# ─────────────────────────────────────────────────────────────

# Homebrew — sets PATH, MANPATH, HOMEBREW_* (replaces manual /opt/homebrew PATH)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Rust / Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# uv — Python lives entirely under uv (no pyenv / mise). Adds ~/.local/bin.
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# zoxide — smart `cd` (z / zi); ALSO records visited dirs that sesh reuses.
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# fzf — key bindings (Ctrl-R history, Ctrl-T files, Alt-C cd) + completion.
command -v fzf >/dev/null && eval "$(fzf --zsh)"
