#!/usr/bin/env bash
# Claude Code PreToolUse guard (matcher: Write|Edit) — blocks writing obvious secrets.
# High-signal patterns only. exit 2 blocks the write; stderr is shown to Claude.
input=$(cat 2>/dev/null)
content=$(printf '%s' "$input" | jq -r '(.tool_input.content // .tool_input.new_string // empty)' 2>/dev/null)
[ -z "$content" ] && exit 0

hit=""
printf '%s' "$content" | grep -Eq 'AKIA[0-9A-Z]{16}'                         && hit="AWS access key ID"
printf '%s' "$content" | grep -Eq -- '-----BEGIN [A-Z ]*PRIVATE KEY-----'    && hit="private key block"
printf '%s' "$content" | grep -Eq 'gh[pousr]_[A-Za-z0-9]{20,}'               && hit="GitHub token"
printf '%s' "$content" | grep -Eiq 'aws_secret_access_key[[:space:]]*=[[:space:]]*[A-Za-z0-9/+]{20,}' && hit="AWS secret access key"

if [ -n "$hit" ]; then
  echo "🛑 Secret scan blocked write: possible $hit. Use an env var / secret manager, not a committed file." >&2
  exit 2
fi
exit 0
