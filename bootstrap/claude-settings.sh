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

eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null \
      || /usr/local/bin/brew shellenv 2>/dev/null \
      || /home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null)" 2>/dev/null || true
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

base="$REPO/claude/settings.json"
overlay="$HOME/.claude/settings.local.json"
dst="$HOME/.claude/settings.json"

mkdir -p "$HOME/.claude"

if [ ! -f "$base" ]; then
  echo "! claude-settings: $base missing -- skipped" >&2
  exit 0
fi

# backup settings.json to claude-settings-<timestamp>.json
if [ -f "$dst" ]; then
  bak="$HOME/.dotfiles-backup/claude-settings-$(date +%Y%m%d-%H%M%S).json"
  mkdir -p "$(dirname "$bak")"
  cp "$dst" "$bak" && echo "▶ backed up existing settings.json → $bak"
fi

# deep-merge base + overlay (overlay wins), jq with python fallback
merge() {   # $1=base  $2=overlay  $3=dst
  local tmp="$3.tmp.$$"
  if command -v jq >/dev/null 2>&1; then
    jq -s '.[0] * .[1]' "$1" "$2" > "$tmp" || { rm -f "$tmp"; return 1; }

  else
    python3 - "$1" "$2" "$tmp" <<'PY' || { rm -f "$tmp"; return 1; }
import json, sys
def deep(a, b):
    if isinstance(a, dict) and isinstance(b, dict):
        out = dict(a)
        for k, v in b.items():
            out[k] = deep(a[k], v) if k in a else v
        return out
    return b
base = json.load(open(sys.argv[1]))
over = json.load(open(sys.argv[2]))
with open(sys.argv[3], "w") as f:
    json.dump(deep(base, over), f, indent=2)
PY

  fi

  mv "$tmp" "$3"
}

if [ -f "$overlay" ]; then
  if merge "$base" "$overlay" "$dst"; then
    echo "✓ merged settings.json (base + settings.local.json)"

  else
    echo "✗ merge failed (need jq or python3) -- left existing settings.json untouched" >&2

  fi

else
  cp "$base" "$dst"
  echo "✓ copied settings.json (no ~/.claude/settings.local.json overlay)"

fi
