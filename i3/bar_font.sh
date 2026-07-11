#!/bin/bash
dir="$(dirname "$0")"
config="$dir/config"
current=$(grep -oP '(?<=^\s{8}font pango:Iosevka )\d+' "$config")

case "$1" in
  +) new=$((current + 1)) ;;
  -) new=$((current - 1)) ;;
  *) echo "usage: bar_font.sh {+|-}"; exit 1 ;;
esac

if [ "$new" -lt 6 ] || [ "$new" -gt 20 ]; then exit 1; fi

sed -i "s/^\( \{8\}font pango:Iosevka \)$current/\1$new/" "$config"
i3-msg restart
