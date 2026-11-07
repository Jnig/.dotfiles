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
defaults write org.p0deje.Maccy historySize -int 999
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

# Dock: group windows by app in Mission Control
defaults write com.apple.dock expose-group-apps -bool true
killall Dock
