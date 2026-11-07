#!/bin/bash

ln -sfn ~/.dotfiles/zshrc ~/.zshrc
ln -sfn ~/.dotfiles/zimrc ~/.zimrc
ln -sfn ~/.dotfiles/p10k.zsh ~/.p10k.zsh
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/.dotfiles/zsh/ssh.zsh ~/.zsh/ssh.zsh

ln -sfn ~/.dotfiles/config/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/config/karabiner ~/.config/karabiner
ln -sfn ~/.dotfiles/config/aerospace ~/.config/aerospace
ln -sfn ~/.dotfiles/config/ghostty ~/.config/ghostty



ln -sfn ~/.dotfiles/ssh/rc ~/.ssh/

brew install \
  exa \
  jq \
  fzf \
  ripgrep \
  wget \
  curl \
  cmake \
  git \
  neovim \
  stylua \
  htop \
  node \
  tmux \
  MisterTea/et/et \
  python3 \
  ruff


brew install --cask \
  ghostty \
  font-fira-code-nerd-font \
  font-hack-nerd-font \
  font-iosevka-nerd-font \
  karabiner-elements \
  google-chrome \
  obsidian \
  maccy \
  nikitabobko/tap/aerospace


# settings
~/.dotfiles/setup-macos.sh
