#!/bin/bash
dots="$HOME/.config/dotfiles"
local_cfg="$dots/i3/config.local"

find "$dots/i3/themes/wallpapers" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.bmp' \) | sort > /tmp/wallpaper-list

[ -s /tmp/wallpaper-list ] || { notify-send "Wallpaper Picker" "No wallpapers found"; exit 1; }

rofi -dmenu -i -p "  Wallpaper  " -theme-str 'window {width: 500;} listview {lines: 12;}' < <(
    while IFS= read -r f; do
        name=$(basename "$f")
        theme=$(basename "$(dirname "$f")")
        echo "  $name  ($theme)"
    done < /tmp/wallpaper-list
) > /tmp/wallpaper-choice

chosen=$(cat /tmp/wallpaper-choice)
[ -z "$chosen" ] && exit 0

sel_name=$(echo "$chosen" | sed 's/^ *//; s/ *([^)]*)$//')
wallpaper=$(grep -F "/$sel_name" /tmp/wallpaper-list | head -1)

[ -z "$wallpaper" ] && notify-send "Wallpaper Picker" "File not found" && exit 1

feh --bg-fill "$wallpaper"
sed -i "s|^WALLPAPER=.*|WALLPAPER=$wallpaper|" "$local_cfg" 2>/dev/null || \
    echo "WALLPAPER=$wallpaper" >> "$local_cfg"
notify-send "Wallpaper" "$(basename "$wallpaper")"
