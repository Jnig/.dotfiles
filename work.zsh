#!/usr/bin/zsh

if ! pgrep -x "adfs-cli" > /dev/null
then
    rm ~/.aws/current_profile
fi
export http_proxy=http://localhost:3128
export https_proxy=http://localhost:3128
unset all_proxy
unset ALL_PROXY

PROMPT="$(cat ~/.aws/current_profile 2> /dev/null)${PROMPT}"

