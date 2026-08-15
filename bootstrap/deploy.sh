#!/usr/bin/env bash
# bootstrap/deploy.sh — copy repo configs into $HOME per the manifest.
#   ./deploy.sh            deploy everything for this OS
#   ./deploy.sh --minimal  deploy only the primitive set (vim/bash/git/ssh) — for bare boxes
set -o pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/lib.sh"
# shellcheck source=/dev/null
source "$DIR/manifest.sh"

MINIMAL=0
[ "${1:-}" = "--minimal" ] && MINIMAL=1

log "Deploying dotfiles from $REPO_DIR  (OS=$OS, minimal=$MINIMAL)"
log "Backups of anything overwritten → $BACKUP_DIR"

deploy_one() {
  local src="$1" dst_rel="$2" flags="$3"
  has_flag "$flags" mac   && [ "$OS" != macos ] && return 0
  has_flag "$flags" linux && [ "$OS" != linux ] && return 0
  [ "$MINIMAL" -eq 1 ] && ! has_flag "$flags" minimal && return 0

  local abs_src="$REPO_DIR/$src" abs_dst="$HOME/$dst_rel"
  [ -e "$abs_src" ] || { warn "missing in repo, skipped: $src"; return 0; }

  # ~/.ssh (and similar) needs 700 on its parent dir
  mkdir -p "$(dirname "$abs_dst")"
  has_flag "$flags" dirperms700 && chmod 700 "$(dirname "$abs_dst")"

  # special: settings.json = base merged with an untracked per-machine overlay
  if has_flag "$flags" merge; then
    backup_path "$abs_dst"
    local overlay="$HOME/.claude/settings.local.json"
    if [ -f "$overlay" ] && have jq; then
      if jq -s '.[0] * .[1]' "$abs_src" "$overlay" > "$abs_dst"; then
        ok "merged $dst_rel (base + settings.local.json)"
      else
        err "jq merge failed for $dst_rel — deployed base only"; cp "$abs_src" "$abs_dst"
      fi
    else
      cp "$abs_src" "$abs_dst"; ok "copied $dst_rel (no ~/.claude/settings.local.json overlay)"
    fi
    return 0
  fi

  backup_path "$abs_dst"
  if has_flag "$flags" dir; then
    local ex; ex="$(flag_value "$flags" exclude)"
    if have rsync; then
      if [ -n "$ex" ]; then rsync -a --exclude "$ex" "$abs_src/" "$abs_dst/"
      else                  rsync -a "$abs_src/" "$abs_dst/"; fi
    else
      cp -R "$abs_src/." "$abs_dst/"
    fi
  else
    cp "$abs_src" "$abs_dst"
  fi

  has_flag "$flags" perms600 && chmod 600 "$abs_dst"
  if has_flag "$flags" exec; then
    if has_flag "$flags" dir; then find "$abs_dst" -name '*.sh' -exec chmod +x {} +
    else chmod +x "$abs_dst"; fi
  fi
  ok "deployed $dst_rel"
}

for rec in "${MANIFEST[@]}"; do
  IFS='|' read -r src dst flags <<< "$rec"
  deploy_one "$src" "$dst" "$flags"
done

cat <<EOF

${C_G}── Deploy complete. Manual follow-ups: ──${C_0}
  • Shell:    chsh -s "\$(command -v zsh)"        # then log out / back in
  • git-lfs:  git lfs install
  • tmux:     start tmux, then press  <prefix> + I   (installs TPM plugins)
  • nvim:     launch nvim — lazy.nvim auto-installs plugins; then  :Lazy sync  ·  :TSUpdate  ·  :checkhealth
              (Mason installs LSP servers/formatters on first use)
  • Ghostty (mac): System Settings → Privacy & Security → Accessibility → enable Ghostty
                   (required for the global quick-terminal keybind)
  • Fonts:    mac installs FiraCode Nerd Font via Brewfile; on a GUI Linux box install it manually
  • Work mac: create ~/.claude/settings.local.json with your Amazon Bedrock block, then re-run
              deploy — settings.json is a jq merge of the public base + that private overlay
  • AL2023:   neovim is the AppImage build; the Rust CLIs (rg/fd/bat/zoxide) come from cargo
EOF
