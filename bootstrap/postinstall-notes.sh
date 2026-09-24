#!/usr/bin/env bash
# echo manual steps needed from user

usage() { echo "Usage: postinstall-notes.sh [-h]   (prints manual follow-up steps; takes no options)"; }
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    *)         echo "postinstall-notes.sh: unexpected argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

G=$'\e[32m'; Z=$'\e[0m'; [ -t 1 ] || { G=; Z=; }
cat <<EOF

${G}--- Setup complete. Manual follow-ups: ---${Z}
  • GitHub:   gh auth login
  • Ghostty (mac): System Settings → Privacy & Security → Accessibility → enable Ghostty
                   (required for the global quick-terminal keybind)
  • Work mac: create ~/.claude/settings.local.json / ~/.codex/config.local.toml with your
              private keys, then re-run ./install -- both are a yq merge of the public base + overlay
  • Codex:    run /hooks once and trust the shared hooks (Codex skips untrusted hooks)

  Day-to-day sync:
    repo → env  :  git pull
    env  → repo :  edit in place, then git add / commit / push
EOF
