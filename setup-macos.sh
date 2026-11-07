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
add_login_item "AeroSpace" "/Applications/AeroSpace.app"

# Dock: group windows by app in Mission Control
defaults write com.apple.dock expose-group-apps -bool true
killall Dock
