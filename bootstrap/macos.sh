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

echo "▶ Keyboard: Caps Lock → Escape (every connected keyboard)"
# HID usage page 7 keycodes: Caps Lock 0x39, Escape 0x29
caps=0x700000039 esc=0x700000029
hidutil property --set "{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":$caps,\"HIDKeyboardModifierMappingDst\":$esc}]}" >/dev/null
# hidutil resets on reboot; the per-keyboard pref below is what System Settings persists.
# keyboards first connected after this run need macos.sh re-run.
hidutil list --matching keyboard | awk '$4 == 1 && $5 == 6 { print $1, $2 }' | sort -u \
  | while read -r vid pid; do
      defaults -currentHost write -g "com.apple.keyboard.modifiermapping.$((vid))-$((pid))-0" -array \
        "<dict><key>HIDKeyboardModifierMappingSrc</key><integer>$((caps))</integer><key>HIDKeyboardModifierMappingDst</key><integer>$((esc))</integer></dict>"
    done

echo "▶ Keyboard: text input"
defaults write -g ApplePressAndHoldEnabled             -bool false   # key repeat instead of the accent popup
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled     -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled  -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled   -bool false
defaults write -g AppleKeyboardUIMode                  -int 2        # Tab moves focus across all dialog controls
defaults write com.apple.HIToolbox AppleFnUsageType    -int 1        # Fn/globe key changes input source

echo "▶ Appearance & windows"
defaults write -g AppleInterfaceStyle -string "Dark"
defaults write -g AppleShowAllExtensions      -bool true
defaults write -g NSTableViewDefaultSizeMode  -int 1       # small sidebar icons
defaults write com.apple.WindowManager EnableTiledWindowMargins         -bool false
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

echo "▶ Trackpad & scrolling"
defaults write -g com.apple.trackpad.scaling   -float 1       # tracking speed (UI slider)
defaults write -g com.apple.swipescrolldirection -bool false # natural scrolling OFF
defaults write -g com.apple.trackpad.forceClick -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false                   # tap to click OFF
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false

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
defaults write com.apple.dock autohide-delay         -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
defaults write com.apple.dock show-recents           -bool false
defaults write com.apple.dock minimize-to-application -bool true

echo "▶ Hot corners: all disabled"
for corner in tl tr bl br; do
  defaults write com.apple.dock "wvous-$corner-corner"   -int 1
  defaults write com.apple.dock "wvous-$corner-modifier" -int 0
done

echo "▶ Finder"
defaults write com.apple.finder FXPreferredViewStyle           -string "Nlsv"   # list view
defaults write com.apple.finder AppleShowAllFiles              -bool true
defaults write com.apple.finder ShowPathbar                    -bool true
defaults write com.apple.finder ShowStatusBar                  -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle        -bool true
defaults write com.apple.finder _FXSortFoldersFirst            -bool true
defaults write com.apple.finder FXDefaultSearchScope           -string "SCcf"   # search the current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXRemoveOldTrashItems          -bool true       # empty Trash after 30 days
defaults write com.apple.finder NewWindowTarget                -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath            -string "file://$HOME/Desktop/"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop     -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop         -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores     -bool true

echo "▶ Menu bar: 24h clock, battery %"
defaults write com.apple.menuextra.clock Show24Hour  -bool true
defaults write com.apple.menuextra.clock ShowSeconds -bool false
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

echo "▶ Screenshots: ~/Pictures/Screenshots, png, no window shadow"
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location       -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture type           -string png
defaults write com.apple.screencapture disable-shadow -bool true

echo "▶ Touch ID for sudo"
if [ -f /etc/pam.d/sudo_local ] && grep -q pam_tid.so /etc/pam.d/sudo_local; then
  echo "  already enabled"
else
  # sudo_local is included by /etc/pam.d/sudo on macOS 14+ and survives OS updates.
  sudo sh -c 'echo "auth       sufficient     pam_tid.so" > /etc/pam.d/sudo_local'
  echo "  enabled -- Touch ID will now authorize sudo"
fi

echo "▶ Docker: load Homebrew's compose + buildx plugins"
# Homebrew installs them outside ~/.docker/cli-plugins, so `docker compose` is unknown without this.
docker_config="$HOME/.docker/config.json"
plugins="$(brew --prefix)/lib/docker/cli-plugins"
mkdir -p "$(dirname "$docker_config")"
[ -f "$docker_config" ] || echo '{}' > "$docker_config"
jq --arg d "$plugins" '.cliPluginsExtraDirs = [$d]' "$docker_config" > "$docker_config.tmp" \
  && mv "$docker_config.tmp" "$docker_config"

# apply the domains that have a live UI (safe if the process isn't running)
echo "▶ Restarting Dock / Finder / SystemUIServer / ControlCenter to apply"
for app in Dock Finder SystemUIServer ControlCenter; do killall "$app" 2>/dev/null || true; done

echo "✔ done. Log out/in (or restart) for key-repeat, trackpad/scroll, and gesture changes to apply everywhere."
