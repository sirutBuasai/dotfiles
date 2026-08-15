#!/usr/bin/env bash
# bootstrap/lib.sh — shared helpers for the dotfiles bootstrap scripts.
# Sourced by deps.sh / deploy.sh / sync.sh. Not run directly.
set -o pipefail

# ── repo root (parent of this bootstrap/ dir), resolved wherever invoked from ──
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$LIB_DIR/.." && pwd)"

# ── logging (color only when writing to a terminal) ──
if [ -t 1 ]; then
  C_G=$'\e[32m'; C_Y=$'\e[33m'; C_R=$'\e[31m'; C_B=$'\e[34m'; C_0=$'\e[0m'
else
  C_G=; C_Y=; C_R=; C_B=; C_0=
fi
log()  { printf '%s▶%s %s\n' "$C_B" "$C_0" "$*"; }
ok()   { printf '%s✓%s %s\n' "$C_G" "$C_0" "$*"; }
warn() { printf '%s!%s %s\n' "$C_Y" "$C_0" "$*" >&2; }
err()  { printf '%s✗%s %s\n' "$C_R" "$C_0" "$*" >&2; }

have() { command -v "$1" >/dev/null 2>&1; }

# ── OS / package-manager detection ──
detect_os() {
  case "$(uname -s)" in
    Darwin) echo macos ;;
    Linux)  echo linux ;;
    *)      echo unknown ;;
  esac
}
detect_pkgmgr() {
  if   have apt-get; then echo apt
  elif have dnf;     then echo dnf
  elif have yum;     then echo yum
  else echo none; fi
}
OS="$(detect_os)"

# ── per-run backup dir ──
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
backup_path() {  # $1 = absolute path to preserve before overwrite
  local p="$1"
  [ -e "$p" ] || return 0
  local rel="${p#"$HOME"/}" dest
  dest="$BACKUP_DIR/$rel"
  mkdir -p "$(dirname "$dest")"
  cp -a "$p" "$dest" 2>/dev/null && warn "backed up $p → $dest"
}
