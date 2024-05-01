#!/usr/bin/env sh

waybar &

case "$(hostname)" in
    workstation | SuseBook)
        hyprpaper &
        ;;
    mittwald)
        hyprpaper -c ~/.config/hypr/hyprpaper-work.conf &
        swayidle &
        ;;
esac

firefox &
