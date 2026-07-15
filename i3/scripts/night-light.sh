#!/bin/bash
pid=$(pgrep -x redshift)
if [ -n "$pid" ]; then
    redshift -x
    kill "$pid" 2>/dev/null
    notify-send "Night Light" "Disabled"
else
    redshift -O 4500 &
    notify-send "Night Light" "Enabled (4500K)"
fi
