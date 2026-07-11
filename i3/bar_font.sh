#!/bin/bash
local_config="$HOME/.config/dotfiles/i3/config.local"

if [ ! -f "$local_config" ]; then
    echo 'set $bar_font pango:Iosevka 10' > "$local_config"
fi

current=$(grep -oP '(?<=^set \$bar_font pango:Iosevka )\d+' "$local_config")

case "$1" in
  +) new=$((current + 1)) ;;
  -) new=$((current - 1)) ;;
  *) echo "usage: bar_font.sh {+|-}"; exit 1 ;;
esac

if [ "$new" -lt 6 ] || [ "$new" -gt 20 ]; then exit 1; fi

sed -i "s/^\(set \$bar_font pango:Iosevka \)$current/\1$new/" "$local_config"
i3-msg restart
