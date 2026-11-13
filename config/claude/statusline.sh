#!/usr/bin/env bash
# Claude Code status line: 5-hour and weekly plan usage with reset times.
# Claude Code pipes session JSON on stdin; rate_limits is only present for
# Claude.ai subscribers, after the first API response.
# Example: 5h 23% ↻14:30 │ week 41% ↻Mon 09:00

input=$(cat)

# Format a unix timestamp; GNU date (Linux) and BSD date (macOS) differ.
fmt() {
  date -d "@$1" "+$2" 2>/dev/null || date -r "$1" "+$2"
}

# Green below 50%, yellow below 80%, red above.
color() {
  if   (( $1 >= 80 )); then printf '\033[31m'
  elif (( $1 >= 50 )); then printf '\033[33m'
  else                      printf '\033[32m'
  fi
}

window() {  # label, jq path, date format for the reset time
  local pct reset
  read -r pct reset < <(jq -r "$2 | select(. != null) | \"\(.used_percentage | floor) \(.resets_at)\"" <<<"$input")
  [[ -n $pct ]] || return
  printf '%s %s%s%%\033[0m \033[2m↻%s\033[0m' "$1" "$(color "$pct")" "$pct" "$(fmt "$reset" "$3")"
}

five=$(window 5h '.rate_limits.five_hour' '%H:%M')
week=$(window week '.rate_limits.seven_day' '%a %H:%M')

if [[ -n $five && -n $week ]]; then
  printf '%s \033[2m│\033[0m %s' "$five" "$week"
else
  printf '%s%s' "$five" "$week"
fi
