#!/usr/bin/env sh

sleep 1

waybar &

firefox &
emacsclient --alternate-editor= --create-frame &
pavucontrol &

sleep 1

case "$(hostname)" in
workstation | susebook | urbach)
    hyprpaper &
    ;;
fraunhofer)
    hyprpaper -c ~/.config/hypr/hyprpaper-work.conf &
    ;;
esac
