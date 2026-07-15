#!/bin/bash
MARKS=$(i3-msg -t get_marks | python3 -c "import sys,json; print('_shrink' in json.load(sys.stdin))")
if [ "$MARKS" = "True" ]; then
    i3-msg '[con_mark="_shrink"] floating disable, unmark _shrink'
else
    i3-msg 'mark _shrink; floating enable; resize set 75 ppt 75 ppt; move window position center'
fi
