#!/usr/bin/env bash
# generate agent settings: deep-merge the repo base with each machine's local overlay
set -o pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$DIR/.." && pwd)"

usage() { echo "Usage: agent-settings.sh [-h]   (generates ~/.claude/settings.json and ~/.codex/config.toml; takes no options)"; }
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    *)         echo "agent-settings.sh: unexpected argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null \
      || /usr/local/bin/brew shellenv 2>/dev/null \
      || /home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null)" 2>/dev/null || true
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

if ! command -v yq >/dev/null 2>&1; then
  echo "✗ agent-settings: yq missing -- left existing settings untouched" >&2
  exit 0
fi

# Layers merge left to right (later wins; arrays are replaced, not appended).
# keep_existing=1 puts the current dst first, for agents that write their own state into it.
merge_settings() {   # $1=name  $2=base  $3=overlay  $4=dst  $5=keep_existing [0-1]
  local name="$1" base="$2" overlay="$3" dst="$4" keep="$5"
  local fmt="${dst##*.}" layers=() labels=() tmp bak

  if [ ! -f "$base" ]; then
    echo "! $name: $base missing -- skipped" >&2
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  if [ -f "$dst" ]; then
    bak="$HOME/.dotfiles-backup/$name-settings-$(date +%Y%m%d-%H%M%S).$fmt"
    mkdir -p "$(dirname "$bak")"
    cp "$dst" "$bak" && echo "▶ $name: backed up existing $(basename "$dst") → $bak"
    [ "$keep" -eq 1 ] && { layers+=("$dst"); labels+=(existing); }
  fi
  layers+=("$base"); labels+=(base)
  [ -f "$overlay" ] && { layers+=("$overlay"); labels+=("$(basename "$overlay")"); }

  # umask keeps secrets in local overlays private to the user
  tmp="$dst.tmp.$$"
  if (umask 077; yq -p "$fmt" -o "$fmt" eval-all '. as $l ireduce ({}; . * $l)' "${layers[@]}" > "$tmp"); then
    mv "$tmp" "$dst"
    echo "✓ $name: merged $(basename "$dst") ($(IFS=+; echo "${labels[*]}" | sed 's/+/ + /g'))"
  else
    rm -f "$tmp"
    echo "✗ $name: merge failed -- left existing $(basename "$dst") untouched" >&2
  fi
}

merge_settings claude "$REPO/claude/settings.json" "$HOME/.claude/settings.local.json" "$HOME/.claude/settings.json" 0
merge_settings codex  "$REPO/codex/config.toml"    "$HOME/.codex/config.local.toml"    "$HOME/.codex/config.toml"    1
