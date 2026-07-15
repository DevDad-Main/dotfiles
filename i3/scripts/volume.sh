#!/bin/bash
case "$1" in
  up)
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
    [ -z "$vol" ] && vol=0
    if [ "$vol" -le 95 ]; then
      pactl set-sink-volume @DEFAULT_SINK@ +5%
    else
      pactl set-sink-volume @DEFAULT_SINK@ 100%
    fi
    ;;
  down) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
  mute) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
esac

muted=$(pactl get-sink-mute @DEFAULT_SINK@)
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
[ -z "$volume" ] && volume=0

if echo "$muted" | grep -qi "yes"; then
    dunstify -r 1000 -h int:value:0 "Volume — Muted" ""
else
    dunstify -r 1000 -h int:value:"$volume" "Volume — ${volume}%" ""
fi
