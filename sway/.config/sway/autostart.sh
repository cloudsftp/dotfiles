#!/usr/bin/env sh

sleep 1

waybar &

firefox &
emacsclient --alternate-editor= --create-frame %F & # not starting correctly
pavucontrol &

sleep 1

case "$(hostname)" in
workstation | susebook)
    hyprpaper &
    ;;
fraunhofer)
    hyprpaper -c ~/.config/hypr/hyprpaper-work.conf &
    ;;
esac
