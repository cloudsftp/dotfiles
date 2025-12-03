#!/usr/bin/env sh

sleep 1

waybar &

emacsclient --alternate-editor= --create-frame &

firefox &
pavucontrol &

sleep 1

case "$(hostname)" in
workstation | susebook | urbach)
    swaybg -i .config/wallpapers/anime/KagamiStandingNight_disappointed.png &
    ;;
psl1198)
    swaybg -i .config/wallpapers/woods/path_sun.jpg &
    ;;
esac
