#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════
# bootstrap/macos.sh — one-time-per-machine macOS system tweaks.
# Run automatically by deps.sh on macOS, or standalone:  bash bootstrap/macos.sh
# Some changes need a logout/restart to take effect.
# Idempotent: safe to re-run.
# ═══════════════════════════════════════════════════════════════════
set -euo pipefail

echo "▶ Keyboard: key repeat (captured from the source machine)"
# Lower = faster. These are the exact values from this laptop's UI settings.
defaults write -g KeyRepeat        -int 2    # repeat rate  (UI: "Key Repeat")
defaults write -g InitialKeyRepeat -int 15   # repeat delay (UI: "Delay Until Repeat")

# Recommended for vim/nvim: hold a key to REPEAT instead of showing the
# accent-character popup. NOTE: this was NOT set on the source machine — it's a
# recommended addition. Delete this line if you prefer the accent popup.
defaults write -g ApplePressAndHoldEnabled -bool false

echo "▶ Touch ID for sudo (upgrade-safe: /etc/pam.d/sudo_local, not /etc/pam.d/sudo)"
if [ -f /etc/pam.d/sudo_local ] && grep -q pam_tid.so /etc/pam.d/sudo_local; then
  echo "  already enabled"
else
  # sudo_local is included by /etc/pam.d/sudo on macOS 14+ and survives OS updates.
  sudo sh -c 'echo "auth       sufficient     pam_tid.so" > /etc/pam.d/sudo_local'
  echo "  enabled — Touch ID will now authorize sudo"
fi

echo "✔ done. Log out/in (or restart) for key-repeat changes to apply everywhere."
