#!/usr/bin/env bash
# set macOS system preferences
set -euo pipefail

usage() { echo "Usage: macos.sh [-h]   (one-time macOS system tweaks; takes no options)"; }
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    *)         echo "macos.sh: unexpected argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

echo "▶ Keyboard: key repeat "
defaults write -g KeyRepeat        -int 2    # repeat rate  (UI: "Key Repeat")
defaults write -g InitialKeyRepeat -int 15   # repeat delay (UI: "Delay Until Repeat")

echo "▶ Touch ID for sudo"
if [ -f /etc/pam.d/sudo_local ] && grep -q pam_tid.so /etc/pam.d/sudo_local; then
  echo "  already enabled"
else
  # sudo_local is included by /etc/pam.d/sudo on macOS 14+ and survives OS updates.
  sudo sh -c 'echo "auth       sufficient     pam_tid.so" > /etc/pam.d/sudo_local'
  echo "  enabled — Touch ID will now authorize sudo"
fi

echo "✔ done. Log out/in (or restart) for key-repeat changes to apply everywhere."
