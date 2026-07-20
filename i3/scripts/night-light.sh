#!/bin/bash
[ -f ~/.config/i3/config.local ] && source ~/.config/i3/config.local
TEMP=${NIGHT_TEMP:-4500}
LATLON="54.352:18.646"
flag=/tmp/redshift-enabled
if [ -f "$flag" ]; then
    rm -f "$flag"
    notify-send "Night Light" "Disabled"
    nohup redshift -l "$LATLON" -t 6500:"$TEMP" >/dev/null 2>&1 &
else
    touch "$flag"
    pkill redshift 2>/dev/null
    redshift -O "$TEMP"
    notify-send "Night Light" "Enabled (${TEMP}K)"
fi
