#!/usr/bin/env zsh

# core env
export EDITOR="nvim"
export VISUAL="nvim"

# personal bin
export PATH="$HOME/bin:$PATH"

# go (toolchain itself comes from Homebrew; this only adds the GOPATH bin)
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
