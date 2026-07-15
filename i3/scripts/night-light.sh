#!/bin/bash
[ -f ~/.config/i3/config.local ] && source ~/.config/i3/config.local
TEMP=${NIGHT_TEMP:-4500}
flag=/tmp/redshift-enabled
if [ -f "$flag" ]; then
    redshift -x
    rm -f "$flag"
    notify-send "Night Light" "Disabled"
else
    touch "$flag"
    redshift -O "$TEMP"
    notify-send "Night Light" "Enabled (${TEMP}K)"
fi
