#!/usr/bin/env zsh
# ─────────────────────────────────────────────────────────────
# path.zsh — PATH + core environment exports (sourced FIRST)
# ─────────────────────────────────────────────────────────────

# Core env
export EDITOR="nvim"
export VISUAL="nvim"

# Personal bin
export PATH="$HOME/bin:$PATH"

# Go (toolchain itself comes from Homebrew; this only adds the GOPATH bin)
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
