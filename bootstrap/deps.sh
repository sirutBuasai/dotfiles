#!/usr/bin/env bash
# install environment dependencies
# usage:
#   ./deps.sh            full stack
#   ./deps.sh --minimal  core/primitive set only (bash/vim/git/tmux + basics)
set -o pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/lib.sh"

usage() {
  cat <<EOF
Usage: deps.sh [--minimal] [-h]

  --minimal    install the core/primitive set only (git/git-lfs/bash/vim/tmux + basics)
  -h, --help   show this help and exit
EOF
}

# parse args
MINIMAL=0
while [ $# -gt 0 ]; do
  case "$1" in
    --minimal) MINIMAL=1; shift ;;
    -h|--help) usage; exit 0 ;;
    -*)        err "deps.sh: unknown option: $1"; usage >&2; exit 2 ;;
    *)         err "deps.sh: unexpected argument: $1"; usage >&2; exit 2 ;;
  esac
done

# detect + install
OS="$(detect_os)"
log "Installing dependencies  (OS=$OS, minimal=$MINIMAL)"

case "$OS" in
  macos) install_macos "$MINIMAL" ;;
  linux) install_linux "$MINIMAL" ;;
  *)     err "unsupported OS: $(uname -s)"; exit 1 ;;
esac

ok "dependency install done."
[ "$MINIMAL" -eq 1 ] && log "Minimal set installed. Re-run without --minimal for the full stack."
