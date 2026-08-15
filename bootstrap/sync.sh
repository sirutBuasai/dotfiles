#!/usr/bin/env bash
# bootstrap/sync.sh — pull LIVE configs from $HOME back into the repo (for review + commit).
#   ./sync.sh              sync everything (except `nosync` entries)
#   ./sync.sh nvim tmux    sync only entries under those top-level repo dirs
set -o pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/lib.sh"
# shellcheck source=/dev/null
source "$DIR/manifest.sh"

want=("$@")
match() {                      # true if no filter given, or $1's top dir is in the filter list
  [ ${#want[@]} -eq 0 ] && return 0
  local top="${1%%/*}" w
  for w in "${want[@]}"; do [ "$w" = "$top" ] && return 0; done
  return 1
}

log "Syncing live configs → $REPO_DIR"
for rec in "${MANIFEST[@]}"; do
  IFS='|' read -r src dst flags <<< "$rec"
  has_flag "$flags" nosync && continue          # public-safety: never pull secrets back
  match "$src" || continue

  abs_src="$HOME/$dst"; abs_dst="$REPO_DIR/$src"
  [ -e "$abs_src" ] || { warn "not on this machine, skipped: $dst"; continue; }

  if has_flag "$flags" dir; then
    ex="$(flag_value "$flags" exclude)"
    if [ -n "$ex" ]; then rsync -a --delete --exclude "$ex" "$abs_src/" "$abs_dst/"
    else                  rsync -a --delete "$abs_src/" "$abs_dst/"; fi
  else
    mkdir -p "$(dirname "$abs_dst")"; cp "$abs_src" "$abs_dst"
  fi
  ok "synced $dst → $src"
done

warn "settings.json is intentionally NOT synced (keeps Amazon keys out of the public repo)."
log  "Review with:  git -C $REPO_DIR diff    then commit & push."
