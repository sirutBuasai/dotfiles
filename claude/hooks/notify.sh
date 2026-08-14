#!/usr/bin/env bash
# Notification + Stop hook — play a sound, but not too often. Gated by:
#   • how long this turn has run (start stamped by prompt-start.sh), and
#   • whether the terminal is focused.
#     focused   → notify only if the turn ran > 60s (you're watching; skip quick ones)
#     unfocused → notify if the turn ran > 30s (you're away; ping sooner)
# Side-effect only; exit code is ignored for these events.
input=$(cat 2>/dev/null)
event=$(printf '%s' "$input" | jq -r '.hook_event_name // empty' 2>/dev/null)
sid=$(printf '%s' "$input" | jq -r '.session_id // "default"' 2>/dev/null)

# ── elapsed since this turn started ────────────────────────────────────────
start_file="${TMPDIR:-/tmp}/claude-turn-start-${sid}"
now=$(date +%s)
if [[ -r "$start_file" ]] && start=$(cat "$start_file" 2>/dev/null) && [[ "$start" =~ ^[0-9]+$ ]]; then
  elapsed=$(( now - start ))
else
  elapsed=99999   # unknown → don't suppress
fi

# ── terminal focused? frontmost app is a known terminal emulator ───────────
# CC_NOTIFY_FOCUS=yes|no overrides detection (for testing).
focused="no"
if [[ -n "${CC_NOTIFY_FOCUS:-}" ]]; then
  focused="$CC_NOTIFY_FOCUS"
elif command -v lsappinfo >/dev/null 2>&1; then
  fa=$(lsappinfo info -only name "$(lsappinfo front 2>/dev/null)" 2>/dev/null | sed -E 's/.*"LSDisplayName"="?([^"]*)"?.*/\1/')
  case "$fa" in Ghostty|kitty|iTerm2|Terminal|Alacritty|WezTerm|Hyper|Warp) focused="yes" ;; esac
fi
# non-macOS (no lsappinfo) and no override → focused stays "no" (ping sooner)

if [[ "$focused" == "yes" ]]; then threshold=60; else threshold=30; fi

# ── debug: print the decision instead of playing (CC_NOTIFY_DEBUG=1) ───────
if [[ "${CC_NOTIFY_DEBUG:-}" == "1" ]]; then
  printf 'event=%s focused=%s elapsed=%ss threshold=%ss -> %s\n' \
    "$event" "$focused" "$elapsed" "$threshold" \
    "$([ "$elapsed" -ge "$threshold" ] && echo PLAY || echo silent)"
  exit 0
fi

(( elapsed < threshold )) && exit 0   # too quick for the current focus state → stay silent

# ── play ───────────────────────────────────────────────────────────────────
play() { # $1 = macOS system sound name
  if command -v afplay >/dev/null 2>&1; then afplay "/System/Library/Sounds/$1.aiff" >/dev/null 2>&1 &
  elif command -v paplay >/dev/null 2>&1; then paplay /usr/share/sounds/freedesktop/stereo/complete.oga >/dev/null 2>&1 &
  fi
}
case "$event" in
  Notification) play Funk ;;   # CC wants input
  Stop)         play Glass ;;  # CC finished a turn
  *)            play Glass ;;
esac
exit 0
