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

echo "▶ Appearance: Dark mode"
defaults write -g AppleInterfaceStyle -string "Dark"

echo "▶ Trackpad & scrolling"
defaults write -g com.apple.trackpad.scaling   -float 1       # tracking speed (UI slider)
defaults write -g com.apple.swipescrolldirection -bool false # natural scrolling OFF

echo "▶ Trackpad gestures (three/four-finger swipes)"
for dom in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
  defaults write "$dom" UserPreferences                      -int 1   # honor these custom values
  defaults write "$dom" TrackpadThreeFingerHorizSwipeGesture -int 2   # 3-finger L/R -> switch desktops / full-screen apps
  defaults write "$dom" TrackpadThreeFingerVertSwipeGesture  -int 2   # 3-finger up -> Mission Control, down -> App Expose
  defaults write "$dom" TrackpadFourFingerHorizSwipeGesture  -int 2   # 4-finger L/R -> switch desktops
  defaults write "$dom" TrackpadFourFingerVertSwipeGesture   -int 2   # 4-finger up -> Mission Control
  defaults write "$dom" TrackpadFourFingerPinchGesture       -int 2   # 4-finger pinch -> Launchpad
  defaults write "$dom" TrackpadFiveFingerPinchGesture       -int 2   # 5-finger spread -> Show Desktop
  defaults write "$dom" TrackpadThreeFingerDrag              -int 0   # 3-finger drag OFF
  defaults write "$dom" TrackpadThreeFingerTapGesture        -int 0   # 3-finger tap (look up) OFF
done

echo "▶ Menu bar: auto-hide"
defaults write -g _HIHideMenuBar -bool true

echo "▶ Dock"
defaults write com.apple.dock autohide       -bool true   # auto-hide the Dock
defaults write com.apple.dock tilesize       -int  45     # icon size
defaults write com.apple.dock magnification  -bool true   # magnify on hover
defaults write com.apple.dock largesize      -int  60     # magnified icon size
defaults write com.apple.dock mru-spaces     -bool false  # don't auto-rearrange Spaces

echo "▶ Finder: list view by default"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo "▶ Touch ID for sudo"
if [ -f /etc/pam.d/sudo_local ] && grep -q pam_tid.so /etc/pam.d/sudo_local; then
  echo "  already enabled"
else
  # sudo_local is included by /etc/pam.d/sudo on macOS 14+ and survives OS updates.
  sudo sh -c 'echo "auth       sufficient     pam_tid.so" > /etc/pam.d/sudo_local'
  echo "  enabled — Touch ID will now authorize sudo"
fi

# apply the domains that have a live UI (safe if the process isn't running)
echo "▶ Restarting Dock / Finder / SystemUIServer to apply"
killall Dock           2>/dev/null || true
killall Finder         2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "✔ done. Log out/in (or restart) for key-repeat, trackpad/scroll, and gesture changes to apply everywhere."
