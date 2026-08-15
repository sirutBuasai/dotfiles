#!/usr/bin/env bash
# UserPromptSubmit hook stamp the start time of each turn for notify.sh to play a sound

input=$(cat 2>/dev/null)
sid=$(printf '%s' "$input" | jq -r '.session_id // "default"' 2>/dev/null)
date +%s > "${TMPDIR:-/tmp}/claude-turn-start-${sid}" 2>/dev/null
exit 0
