#!/usr/bin/env sh

sleep 1

waybar &

(
    while ! systemctl --user is-active emacs; do sleep 1; done
    emacsclient --alternate-editor= --create-frame
) &

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
workstation | susebook | urbach)
    photo="$(woods bench_plants.jpg)"
    ;;
psl1198)
    photo="$(woods path_sun.jpg)"
    ;;
esac

swaybg -i $photo &
