#!/usr/bin/env bash
# Agent PreToolUse guard (matcher: Write|Edit|apply_patch) -- blocks writing obvious secrets.
# High-signal patterns only. exit 2 blocks the write; stderr is shown to the agent.

input=$(cat 2>/dev/null)
# old_string is excluded so edits that remove a secret aren't blocked.
content=$(printf '%s' "$input" | jq -r '.tool_input // {} | del(.old_string) | [.. | strings] | join("\n")' 2>/dev/null)
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
