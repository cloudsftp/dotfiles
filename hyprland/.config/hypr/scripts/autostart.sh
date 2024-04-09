#!/usr/bin/env sh

waybar &

case "$HOSTNAME" in
    workstation)
        hyprpaper &
        ;;
    mittwald)
        hyprpaper -c ~/.config/hypr/hyprpaper-work.conf &
        swayidle &
        ;;
esac

firefox &
