#!/bin/bash
sudo apt instal gawk zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc

zplugin module build

npm config set prefix ~/.npm

# install hack nerd font
cd /tmp
wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip -x Hack-v3.003-ttf.zip
sudo mv ttf/* /usr/local/share/fonts
fc-cache -f -v
fc-list | grep "Hack" | grep -i Nerd
