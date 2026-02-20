#!/usr/bin/env sh

sleep 1

waybar &

emacsclient --alternate-editor= --create-frame &

firefox &
pavucontrol &

sleep 1

anime() {
    echo .config/wallpapers/anime/$1
}

woods() {
    echo .config/wallpapers/woods/$1
}

case "$(hostname)" in
workstation)
    photo="$(woods bench_plants.jpg)"
    ;;
susebook | urbach)
    photo="$(anime KagamiStandingNight_disappointed.png)"
    ;;
psl1198)
    photo="$(woods path_sun.jpg)"
    ;;
esac

swaybg -i $photo &
