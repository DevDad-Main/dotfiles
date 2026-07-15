#!/bin/bash
flag=/tmp/redshift-enabled
if [ -f "$flag" ]; then
    redshift -x
    rm -f "$flag"
    notify-send "Night Light" "Disabled"
else
    touch "$flag"
    redshift -O 4500
    notify-send "Night Light" "Enabled (4500K)"
fi
