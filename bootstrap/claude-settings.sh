#!/usr/bin/env bash
# merge claude settings.json with local settings.local.json
set -o pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$DIR/.." && pwd)"

usage() { echo "Usage: claude-settings.sh [-h]   (generates ~/.claude/settings.json; takes no options)"; }
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    *)         echo "claude-settings.sh: unexpected argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

base="$REPO/claude/settings.json"
overlay="$HOME/.claude/settings.local.json"
dst="$HOME/.claude/settings.json"

mkdir -p "$HOME/.claude"

if [ ! -f "$base" ]; then
  echo "! claude-settings: $base missing -- skipped" >&2
  exit 0
fi

if [ -f "$overlay" ] && command -v jq >/dev/null 2>&1; then
  if jq -s '.[0] * .[1]' "$base" "$overlay" > "$dst"; then
    echo "✓ merged settings.json (base + settings.local.json)"

  else
    echo "✗ jq merge failed -- writing base only" >&2
    cp "$base" "$dst"

  fi

else
  cp "$base" "$dst"
  echo "✓ copied settings.json (no ~/.claude/settings.local.json overlay)"

fi
