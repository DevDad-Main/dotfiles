#!/bin/bash
[ -f ~/.config/i3/config.local ] && source ~/.config/i3/config.local
TEMP=${NIGHT_TEMP:-4500}
LATLON="54.352:18.646"
flag=/tmp/redshift-enabled

pkill -9 redshift 2>/dev/null

if [ -f "$flag" ]; then
    rm -f "$flag"
    nohup redshift -l "$LATLON" -t 6500:"$TEMP" >/dev/null 2>&1 &
    notify-send "Night Light" "Disabled"
else
    touch "$flag"
    redshift -P -O "$TEMP"
    notify-send "Night Light" "Enabled (${TEMP}K)"
fi
