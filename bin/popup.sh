#!/usr/bin/env bash -x

TITLE=mylauncher

SCREEN_WIDTH=`yabai -m query --displays --display | jq .frame.w*2`
SCREEN_HEIGHT=`yabai -m query --displays --display | jq .frame.h*2`
SCREEN_OFFSET=`yabai -m query --displays --display | jq .frame.x*2`

TERM_WIDTH=1280
TERM_HEIGHT=800

let "X=SCREEN_WIDTH/2+SCREEN_OFFSET/4-TERM_WIDTH/2"
let "Y=(SCREEN_HEIGHT/2-TERM_HEIGHT/2)-TERM_HEIGHT"

alacritty -v -t "${TITLE}" -o window.position.x="${X}" -o window.position.y="${Y}" -o window.dimensions.lines=35 -o window.dimensions.columns=80 -o window.decorations=none --working-directory "$(pwd)" -e "$1"

