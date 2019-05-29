#!/bin/bash
sudo apt instal gawk zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc

zplugin module build

npm config set prefix ~/.npm
