#!/bin/bash
# macOS system settings. Safe to run multiple times.
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  echo "setup-macos.sh: not macOS, skipping" >&2
  exit 0
fi

# Add an app to Login Items, unless it is already there.
add_login_item() {
  local name="$1" path="$2"
  if [[ ! -d "$path" ]]; then
    echo "Login item: $path not found, skipping" >&2
    return
  fi
  if osascript -e 'tell application "System Events" to get the name of every login item' | grep -qw "$name"; then
    echo "Login item: $name already present"
  else
    osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$path\", hidden:true}" >/dev/null
    echo "Login item: added $name"
  fi
}

# Ghostty runs at login so its global Cmd+Enter keybind is always available
add_login_item "Ghostty" "/Applications/Ghostty.app"

# Time Out (break reminders, 20-20-20 rule)
add_login_item "Time Out" "/Applications/Time Out.app"

# Maccy (clipboard manager). AeroSpace handles its own via start-at-login in its config.
add_login_item "Maccy" "/Applications/Maccy.app"

# SSH: keep key passphrases in the macOS Keychain and load keys automatically
mkdir -p ~/.ssh && chmod 700 ~/.ssh
touch ~/.ssh/config && chmod 600 ~/.ssh/config
if grep -qi '^\s*UseKeychain' ~/.ssh/config; then
  echo "SSH: keychain config already present"
else
  printf '\nHost *\n  AddKeysToAgent yes\n  UseKeychain yes\n' >> ~/.ssh/config
  echo "SSH: added keychain config"
fi

# Maccy (clipboard manager). Settings only take effect after restarting Maccy.
# Maccy is sandboxed: its prefs live in ~/Library/Containers, which macOS only lets
# the terminal write to with Full Disk Access. Without it, warn and skip.
if ! defaults write org.p0deje.Maccy historySize -int 999 2>/dev/null; then
  echo "Maccy: cannot write settings (grant your terminal Full Disk Access, then rerun); skipping" >&2
else
  defaults write org.p0deje.Maccy popupPosition -string center
  defaults write org.p0deje.Maccy showFooter -bool false
  defaults write org.p0deje.Maccy showSearch -bool true
  defaults write org.p0deje.Maccy searchMode -string fuzzy
  defaults write org.p0deje.Maccy removeFormattingByDefault -bool true   # paste as plain text
  defaults write org.p0deje.Maccy SUEnableAutomaticChecks -bool false     # updated via Homebrew
  defaults write org.p0deje.Maccy KeyboardShortcuts_popup -string '{"carbonKeyCode":9,"carbonModifiers":768}'           # Cmd+Shift+V
  defaults write org.p0deje.Maccy KeyboardShortcuts_pin -string '{"carbonModifiers":2048,"carbonKeyCode":35}'           # Option+P
  defaults write org.p0deje.Maccy KeyboardShortcuts_togglePreview -string '{"carbonKeyCode":49,"carbonModifiers":4096}' # Ctrl+Space
  defaults write org.p0deje.Maccy KeyboardShortcuts_delete -bool false    # no delete shortcut
fi

# Screenshots: Cmd+U copies a selected area to the clipboard (picked up by Maccy),
# Cmd+Shift+U saves it as a file. Parameters: ASCII char, key code, modifier mask.
set_hotkey() {
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$1" \
    "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>$2</integer><integer>$3</integer><integer>$4</integer></array><key>type</key><string>standard</string></dict></dict>"
}
set_hotkey 31 117 32 1048576   # Cmd+U: copy selected area to clipboard
set_hotkey 30 117 32 1179648   # Cmd+Shift+U: save selected area as file
defaults write com.apple.screencapture target clipboard

# Free Ctrl+Space (zsh: accept autosuggestion) and Ctrl+Option+Space,
# which macOS uses by default to switch keyboard input sources
disable_hotkey() {
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$1" \
    "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>$2</integer><integer>$3</integer><integer>$4</integer></array><key>type</key><string>standard</string></dict></dict>"
}
disable_hotkey 60 32 49 262144   # Ctrl+Space: select previous input source
disable_hotkey 61 32 49 786432   # Ctrl+Option+Space: select next input source

# Keyboard: fast key repeat for Neovim (fastest values the System Settings sliders allow;
# units of 15 ms). Holding a key repeats it instead of showing the accent picker.
defaults write -g KeyRepeat -int 2          # 30 ms between repeats (default 6 = 90 ms)
defaults write -g InitialKeyRepeat -int 15  # 225 ms before repeating starts (default 25 = 375 ms)
defaults write -g ApplePressAndHoldEnabled -bool false

# Trackpad/mouse: natural scrolling off
defaults write -g com.apple.swipescrolldirection -bool false

# Sound: no user interface sounds
defaults write -g com.apple.sound.uiaudio.enabled -int 0

# Sound: no chime on startup (NVRAM, needs sudo; only prompts when not yet set)
if [[ "$(nvram StartupMute 2>/dev/null | awk '{print $2}')" == "%01" ]]; then
  echo "Startup sound: already muted"
else
  sudo nvram StartupMute=%01
  echo "Startup sound: muted"
fi

# Apply keyboard shortcut and preference changes without logging out
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Dock: group windows by app in Mission Control
defaults write com.apple.dock expose-group-apps -bool true
killall Dock
