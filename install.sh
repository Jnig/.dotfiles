#!/bin/bash

ln -sfn ~/.dotfiles/zshrc ~/.zshrc
ln -sfn ~/.dotfiles/p10k.zsh ~/.p10k.zsh
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

ln -sfn ~/.dotfiles/config/alacritty ~/.config/alacritty
ln -sfn ~/.dotfiles/config/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/config/karabiner ~/.config/karabiner
ln -sfn ~/.dotfiles/config/skhd ~/.config/skhd
ln -sfn ~/.dotfiles/config/yabai ~/.config/yabai

ln -sfn ~/.dotfiles/lssh/rc  ~/.ssh/


brew install  \
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
  yabai \
  skhd \
  MisterTea/et/et

brew tap homebrew/cask-fonts

brew install --cask \
  alacritty \
  font-fira-code-nerd-font \
  font-hack-nerd-font \
  font-iosevka-nerd-font \
  karabiner-elements \
  google-chrome \
  obsidian \
  spaceid

