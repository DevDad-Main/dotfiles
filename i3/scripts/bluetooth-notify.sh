#!/bin/bash
pkill -x bluetoothctl 2>/dev/null
bluetoothctl monitor 2>/dev/null | while IFS= read -r line; do
    case "$line" in
        *"Connected: yes")
            mac=$(echo "$line" | grep -oP 'Device \K[0-9A-F:]{17}')
            [ -z "$mac" ] && continue
            name=$(bluetoothctl info "$mac" 2>/dev/null | grep "Name:" | cut -d' ' -f2-)
            notify-send "Bluetooth" "Connected: ${name:-$mac}" -i bluetooth
            ;;
        *"Connected: no")
            mac=$(echo "$line" | grep -oP 'Device \K[0-9A-F:]{17}')
            [ -z "$mac" ] && continue
            name=$(bluetoothctl info "$mac" 2>/dev/null | grep "Name:" | cut -d' ' -f2-)
            notify-send "Bluetooth" "Disconnected: ${name:-$mac}" -i bluetooth
            ;;
    esac
done
