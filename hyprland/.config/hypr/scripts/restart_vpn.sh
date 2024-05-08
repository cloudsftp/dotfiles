#!/usr/bin/env sh

if [ "$(hostname)" = "mittwald" ]; then
    function connected_to_network() {
        id="$1"
        if [ "$(nmcli -f GENERAL.STATE con show $id)" ]; then
            echo true
        fi
    }

    function connected_to_internal_network() {
        if [ "$(connected_to_network Hub)" ] || [ "$(connected_to_network Wifi)" ]; then
            echo true
        fi
    }

    if [ "$(connected_to_internal_network)" ]; then
        systemctl --user restart caa
    else
        ~/Projects/NetworkShi/vpn/toggle_vpn.sh
    fi
elif command -v mullvad &> /dev/null; then
    mullvad reconnect
fi
