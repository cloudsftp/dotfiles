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
psl1198)
    hyprpaper -c ~/.config/hypr/hyprpaper-work.conf &
    ;;
esac
