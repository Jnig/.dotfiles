#!/bin/bash
# Set up the dotfiles on macOS or Linux. Safe to run multiple times.
set -euo pipefail

DOTFILES="$HOME/.dotfiles"

link() {
  mkdir -p "$(dirname "$2")"
  ln -sfn "$1" "$2"
  echo "Linked $2"
}

# Shared (macOS + Linux)
link "$DOTFILES/zshrc"          ~/.zshrc
link "$DOTFILES/p10k.zsh"       ~/.p10k.zsh
link "$DOTFILES/tmux/tmux.conf" ~/.tmux.conf
link "$DOTFILES/config/nvim"    ~/.config/nvim

# macOS only
if [[ "$(uname)" == "Darwin" ]]; then
  link "$DOTFILES/config/ghostty"   ~/.config/ghostty
  link "$DOTFILES/config/aerospace" ~/.config/aerospace
  link "$DOTFILES/config/karabiner" ~/.config/karabiner
fi

# Packages (Brewfile skips the macOS apps on Linux)
if command -v brew >/dev/null; then
  brew bundle --file "$DOTFILES/Brewfile"
else
  echo "Homebrew not found, skipping packages. Install it from https://brew.sh and run this again." >&2
fi

# macOS system settings
if [[ "$(uname)" == "Darwin" ]]; then
  "$DOTFILES/setup-macos.sh"
fi
