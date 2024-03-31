#!/usr/bin/env sh

waybar &

case "$HOSTNAME" in
    workstation)
        hyprpaper &
        ;;
    mittwald)
        hyprpaper -c ~/.config/wallpapers/woods/path_sun.jpg &
        swayidle &
        ;;
esac

firefox &
