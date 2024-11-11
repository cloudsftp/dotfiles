#!/usr/bin/env sh

sleep 2

waybar &

firefox &

emacsclient --alternate-editor= --create-frame %F & # not starting correctly

case "$(hostname)" in
    workstation | susebook)
        hyprpaper &
        ;;
    fraunhofer)
        hyprpaper -c ~/.config/hypr/hyprpaper-work.conf &
        ;;
esac
