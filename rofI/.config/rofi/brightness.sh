#!/bin/bash

get_brightness() {
  monitor brightness
}

set_brightness() {
  monitor brightness write "$1"
}

CURRENT="$(printf "%02d" "$(get_brightness)")"

OPTIONS=(01 05 08 10 15 20 30 50 75 100)
[[ " ${OPTIONS[*]} " =~ " $CURRENT " ]] ||  OPTIONS+=("$CURRENT")
OPTIONS="$(printf "%s\n" "${OPTIONS[@]}" | sort -n)"

CHOICE="$( \
  echo "${OPTIONS}" \
  | rofi -dmenu \
    -p $(printf "\uf5de") \
    -select "$CURRENT" \
  )"

[[ -n "$CHOICE" ]] && set_brightness "$CHOICE"

