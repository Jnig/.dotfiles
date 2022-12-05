#!/bin/bash

MULTI=0

if [[ $(yabai -m query --displays | jq '.[]|.id' | wc -l)  -ge 2 ]]; then
  MULTI=1	
fi


function setup_space {
  local idx="$1"
  local name="$2"
  local display="$3"

  local space=
  space=$(yabai -m query --spaces --space "$name")
  if [ -z "$space" ]; then
    yabai -m space --create
  fi

  yabai -m space "$idx" --move "$idx"
  yabai -m space "$idx" --display "$display"
}


if [[ "$MULTI" -eq "1" ]]; then 
  setup_space 1 1
  setup_space 2 2
  setup_space 3 2
  setup_space 4 2
  setup_space 5 2
  setup_space 6 2
  setup_space 7 2
  setup_space 7 2
else 
  setup_space 1 1
  setup_space 2 1
  setup_space 3 1
  setup_space 4 1
  setup_space 5 1
  setup_space 6 1
  setup_space 7 1
fi

brew services restart sketchybar
