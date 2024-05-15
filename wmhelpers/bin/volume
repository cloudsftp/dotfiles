#!/usr/bin/env bash

# Increase Volume
inc_volume() {
	pamixer -i 2 && notify_user
}

# Decrease Volume
dec_volume() {
	pamixer -d 2 && notify_user
}

# Toggle Mute
toggle_mute() {
	if [ "$(pamixer --get-mute)" == "false" ]; then
		pamixer -m
	elif [ "$(pamixer --get-mute)" == "true" ]; then
		pamixer -u
	fi
}

# Execute accordingly
if [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
fi

