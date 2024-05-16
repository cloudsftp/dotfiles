#!/usr/bin/env sh

waybar &

firefox &

emacsclient --alternate-editor= --create-frame %F & # not starting correctly

case "$(hostname)" in
    workstation | SuseBook)
        hyprpaper &
        ;;
    mittwald)
        hyprpaper -c ~/.config/hypr/hyprpaper-work.conf &

        swayidle -w \
            timeout 300 swaylock \
            timeout 360 'swaymsg "output * power off"' \
                resume 'swaymsg "output * power on"' \
            before-sleep swaylock &

        slack &

        sleep 5

        restart_vpn & # not working properly

        ;;
esac

syncthing --no-browser &> /tmp/syncthing.log &
