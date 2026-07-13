#!/bin/bash
# Group focused window with its right neighbor into a nested split container.
# After grouping, use $mod+y to toggle layout for just that pair.

JSON=$(i3-msg 'mark _a; focus right')

RIGHT_OK=$(echo "$JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print('true' if len(data) > 1 and data[1].get('success') else 'false')
")

if [ "$RIGHT_OK" = "true" ]; then
    i3-msg 'mark _b'
    i3-msg '[con_mark=_a] focus; split toggle'
    i3-msg '[con_mark=_b] move window to mark _a'
else
    JSON=$(i3-msg 'focus left')
    LEFT_OK=$(echo "$JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print('true' if len(data) > 0 and data[0].get('success') else 'false')
    ")
    if [ "$LEFT_OK" = "true" ]; then
        i3-msg 'mark _b'
        i3-msg '[con_mark=_a] focus; split toggle'
        i3-msg '[con_mark=_b] move window to mark _a'
    fi
fi

i3-msg 'unmark _a; unmark _b'
