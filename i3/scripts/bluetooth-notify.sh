#!/bin/bash
dbus-monitor --system "sender=org.bluez,interface=org.freedesktop.DBus.Properties,member=PropertiesChanged" 2>/dev/null | while read -r line; do
    mac=$(echo "$line" | grep -oP '/org/bluez/hci0/dev_\K[0-9A-F_]{17}')
    [ -z "$mac" ] && continue
    mac=$(echo "$mac" | tr '_' ':')
    # Keep reading until we find the Connected property
    while read -r next; do
        if echo "$next" | grep -q '"Connected"'; then
            read -r val
            if echo "$val" | grep -q "boolean true"; then
                name=$(bluetoothctl info "$mac" 2>/dev/null | grep "Name:" | cut -d' ' -f2-)
                notify-send -i bluetooth "Bluetooth" "Connected: ${name:-$mac}"
            elif echo "$val" | grep -q "boolean false"; then
                name=$(bluetoothctl info "$mac" 2>/dev/null | grep "Name:" | cut -d' ' -f2-)
                notify-send -i bluetooth "Bluetooth" "Disconnected: ${name:-$mac}"
            fi
            break
        fi
    done
done
