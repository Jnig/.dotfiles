#!/usr/bin/env zsh

find /System/Library/CoreServices /System/Applications /Applications /System/Applications/Utilities $HOME/Applications/ -maxdepth 1 -name "*.app" | fzf | xargs -I {} open "{}"
