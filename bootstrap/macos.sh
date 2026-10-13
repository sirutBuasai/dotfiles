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
defaults write -g shouldShowRSVPDataDetectors          -bool true    # suggest calendar events from Mail/Messages

echo "▶ Keyboard: U.S. + Thai input sources"
if ! defaults read com.apple.HIToolbox AppleEnabledInputSources 2>/dev/null | grep -q '"KeyboardLayout Name" = Thai'; then
  defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
    "<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>-26624</integer><key>KeyboardLayout Name</key><string>Thai</string></dict>"
fi
defaults write com.apple.TextInputMenu visible -bool true
# System Settings enables these when a second source is added; a defaults-only install doesn't.
# 60: Ctrl+Space (previous source), 61: Ctrl+Opt+Space (next source)
for hotkey in "60 262144" "61 786432"; do
  read -r id mods <<<"$hotkey"
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" \
    "<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>$mods</integer></array></dict></dict>"
done
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "▶ Appearance & windows"
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true
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

echo "▶ Menu bar: 24h clock, battery %, sound always shown"
defaults write com.apple.menuextra.clock Show24Hour  -bool true
defaults write com.apple.menuextra.clock ShowSeconds -bool false
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true
defaults -currentHost write com.apple.controlcenter Sound -int 16   # 16 = always, 8 = when active

echo "▶ Siri: on, press either Command key twice, no \"Hey Siri\""
defaults write com.apple.assistant.support "Assistant Enabled" -bool true
defaults write com.apple.Siri VoiceTriggerUserEnabled -bool false
# Encoding copied from what System Settings writes for "Press Either Command Key Twice".
defaults write com.apple.Siri KeyboardShortcutSAE \
  "<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>SAE1.0</string><key>parameters</key><array><integer>32</integer><integer>55</integer><integer>1048600</integer></array></dict></dict>"

echo "▶ Screenshots: ~/Pictures/Screenshots, png, no window shadow"
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location       -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture type           -string png
defaults write com.apple.screencapture disable-shadow -bool true

echo "▶ Touch ID for sudo"
# pam_reattach must precede pam_tid, or Touch ID silently falls back to a password inside tmux.
pam_reattach="$(brew --prefix)/lib/pam/pam_reattach.so"
sudo_local="auth       optional       $pam_reattach ignore_ssh
auth       sufficient     pam_tid.so"
if [ ! -f "$pam_reattach" ]; then
  echo "  pam_reattach missing -- run brew bundle first; Touch ID won't work inside tmux"
  sudo_local="auth       sufficient     pam_tid.so"
fi
if [ "$(cat /etc/pam.d/sudo_local 2>/dev/null)" = "$sudo_local" ]; then
  echo "  already enabled"
else
  # sudo_local is included by /etc/pam.d/sudo on macOS 14+ and survives OS updates.
  printf '%s\n' "$sudo_local" | sudo tee /etc/pam.d/sudo_local >/dev/null
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
