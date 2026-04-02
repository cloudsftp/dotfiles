#!/bin/bash

NAME="$(date +%F-%X-%N)"
SELECT_WINDOW=false
USE_RESNAP=false

while [ $# -gt 0 ]; do
  case "$1" in
  -w | --window)
    SELECT_WINDOW=true
    shift ;;
  -r | --reSnap)
    USE_RESNAP=true
    shift;;
  *)
    NAME="$1"
    shift ;;
  esac
done

DIR="${HOME}/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="${DIR}/${NAME}.png"

if [ "$USE_RESNAP" = "true" ]; then
  reSnap -s "192.168.2.108" -o "$FILE"
elif [ "$SELECT_WINDOW" = "true" ]; then
  maim -i $(xdotool getactivewindow) "$FILE"
else
  maim -s "$FILE"
fi

NAME_OPT="$(echo "<date>" | dmenu)"
if [ -n "$NAME_OPT" ] && [ "$NAME_OPT" != "<date>" ]; then
  OPT_FILE="$FILE"
  FILE="${DIR}/${NAME_OPT}.png"
  mv "$OPT_FILE" "$FILE"
fi

echo -n "$FILE" | xclip -selection clipboard
