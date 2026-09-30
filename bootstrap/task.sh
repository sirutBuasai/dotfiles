#!/usr/bin/env bash
# run one dotbot shell task, teeing its stderr into $DOTFILES_LOG_DIR so ./install can summarize failures.
# usage: task.sh <command> [args...]

[ -n "${DOTFILES_LOG_DIR:-}" ] || exec "$@"

name="$*"
log="$DOTFILES_LOG_DIR/$(printf '%s' "$name" | tr -c 'A-Za-z0-9._-' '_' | cut -c1-80).log"

# only stderr goes through the pipe so stdout stays a TTY (tools keep colors and progress output)
exec 3>&1
"$@" 2>&1 1>&3 3>&- | tee "$log" >&2 3>&-
rc=${PIPESTATUS[0]}

[ "$rc" -eq 0 ] || printf '%s\t%s\t%s\n' "$rc" "$name" "$log" >> "$DOTFILES_LOG_DIR/failed"
exit "$rc"
