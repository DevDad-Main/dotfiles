#!/bin/bash
dots="$HOME/.config/dotfiles"
local_cfg="$dots/i3/config.local"

wallpapers=$(find "$dots/i3/themes/wallpapers" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.gif' -o -name '*.bmp' \) | sort)

[ -z "$wallpapers" ] && notify-send "Wallpaper Picker" "No wallpapers found" && exit 1

entries=""
while IFS= read -r f; do
    name=$(basename "$f")
    entries="$entries  $name\x00icon\x1f$f\n"
done <<< "$wallpapers"

chosen=$(printf "$entries" | rofi -dmenu -i -show-icons -p "  Wallpaper  " -theme-str 'window {width: 750;} listview {lines: 12;}')
[ -z "$chosen" ] && exit 0

sel_name=$(echo "$chosen" | sed 's/^ *//')

wallpaper=""
while IFS= read -r f; do
    [ "$(basename "$f")" = "$sel_name" ] && wallpaper="$f" && break
done <<< "$wallpapers"

[ -z "$wallpaper" ] && notify-send "Wallpaper Picker" "File not found" && exit 1

feh --bg-fill "$wallpaper"
grep -q "^WALLPAPER=" "$local_cfg" 2>/dev/null && \
    sed -i "s|^WALLPAPER=.*|WALLPAPER=$wallpaper|" "$local_cfg" || \
    echo "WALLPAPER=$wallpaper" >> "$local_cfg"
notify-send "Wallpaper" "Set to $(basename "$wallpaper")"
