#!/usr/bin/env bash
# install.sh — one-command setup for a fresh machine.
#   git clone <repo> ~/personal_dev/dotfiles && cd ~/personal_dev/dotfiles
#   ./install.sh            full stack  (install deps, then deploy configs)
#   ./install.sh --minimal  primitive set only (bare EC2: git/zsh/bash/vim/tmux + configs)
#
# Or run the steps individually:
#   bootstrap/deps.sh [--minimal]     # 1) install dependencies
#   bootstrap/deploy.sh [--minimal]   # 2) copy configs into place (+ prints manual steps)
#   bootstrap/sync.sh [app...]        # later: pull live edits back into the repo
set -o pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$DIR/bootstrap/deps.sh"   "$@"
"$DIR/bootstrap/deploy.sh" "$@"
