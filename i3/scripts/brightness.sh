#!/bin/bash
case "$1" in
  up)   brightnessctl s +5% ;;
  down) brightnessctl s 5%- ;;
esac

brightness=$(brightnessctl g)
max=$(brightnessctl m)
percent=$((brightness * 100 / max))

dunstify -r 1001 -h int:value:"$percent" "Brightness — ${percent}%" ""
