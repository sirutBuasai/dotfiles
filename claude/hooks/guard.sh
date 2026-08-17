#!/usr/bin/env bash
# Claude Code PreToolUse guard (matcher: Bash) -- blocks clearly-destructive commands.
# High-signal only, to avoid nagging. exit 2 blocks the tool; stderr is shown to Claude.

input=$(cat 2>/dev/null)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)
[ -z "$cmd" ] && exit 0

c=$(printf '%s' "$cmd" | tr -s '[:space:]' ' ')   # collapse whitespace
block() { echo "🛑 Blocked by ~/.claude guard: $1 -- run it yourself if you're sure." >&2; exit 2; }

# recursive delete of / , ~ , or $HOME
printf '%s' "$c" | grep -Eq 'rm +(-[a-zA-Z]+ +)*-[a-zA-Z]*[rR][a-zA-Z]* +(-[a-zA-Z]+ +)*(/|~|/\*|\$HOME)( |$)' \
  && block "recursive delete of / , ~ , or \$HOME"

# force-push to a protected branch
if printf '%s' "$c" | grep -Eq 'git +push.*(--force|--force-with-lease|-f)\b'; then
  printf '%s' "$c" | grep -Eq '\b(main|master|mainline)\b' && block "force-push to a protected branch"
fi

# piping a remote script straight into a shell
printf '%s' "$c" | grep -Eq '(curl|wget)\b.*\|[[:space:]]*(sudo +)?(ba)?sh\b' \
  && block "piping a remote script into a shell"

exit 0
