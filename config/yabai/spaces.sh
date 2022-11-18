#!/bin/bash

MULTI=0

if [[ $(yabai -m query --displays | jq '.[]|.id' | wc -l)  -ge 2 ]]; then
  MULTI=1	
fi

# cleanup
UNUSED=($(yabai -m query --spaces | jq -r '.[]|select(.label == "")|.index' | tr '\n' ' '))
for i in "${UNUSED[@]}"
do
 echo "removing $i"
 yabai -m space "$i" --destroy
done


function setup_space {
  local idx="$1"
  local name="$2"
  local display="$3"

  local space=
  space=$(yabai -m query --spaces --space "$name")
  if [ -z "$space" ]; then
    yabai -m space --create
  fi

  yabai -m space "$idx" --label "$name"
  yabai -m space "$name" --move "$idx"
  yabai -m space "$name" --display "$display"
}


if [[ "$MULTI" -eq "1" ]]; then 
  setup_space 1 space.7 1
  setup_space 2 space.1 2
  setup_space 3 space.2 2
  setup_space 4 space.3 2
  setup_space 5 space.4 2
  setup_space 6 space.5 2
  setup_space 7 space.6 2
else 
  setup_space 1 space.1 1
  setup_space 2 space.2 1
  setup_space 3 space.3 1
  setup_space 4 space.4 1
  setup_space 5 space.5 1
  setup_space 6 space.6 1
  setup_space 7 space.7 1
fi

brew services restart sketchybar
