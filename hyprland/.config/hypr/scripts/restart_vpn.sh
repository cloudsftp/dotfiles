#!/usr/bin/env sh

if [ $(hostname) = "mittwald" ]; then
    systemctl --user restart caa
elif command -v mullvad &> /dev/null; then
    mullvad reconnect
fi
