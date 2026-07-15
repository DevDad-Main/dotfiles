#!/bin/bash
dots="$HOME/.config/dotfiles"
local_cfg="$dots/i3/config.local"
theme=$(grep "^THEME=" "$local_cfg" 2>/dev/null | cut -d= -f2)

[ -z "$theme" ] && notify-send "Wallpaper Picker" "No active theme" && exit 1

theme_dir="$dots/i3/themes/wallpapers/$theme"
general_dir="$dots/i3/themes/wallpapers/general"

wallpapers=$(find "$theme_dir" "$general_dir" -maxdepth 1 -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.bmp' \) 2>/dev/null | sort)

[ -z "$wallpapers" ] && notify-send "Wallpaper Picker" "No wallpapers for $theme" && exit 1

entries=""
while IFS= read -r f; do
    name=$(basename "$f")
    entries="$entries  $name\x00icon\x1f$f\n"
done <<< "$wallpapers"

chosen=$(printf "$entries" | rofi -dmenu -i -show-icons -p "  $theme wallpaper  " -theme-str 'window {width: 750;} listview {lines: 12;}')
[ -z "$chosen" ] && exit 0

sel_name=$(echo "$chosen" | sed 's/^ *//')

wallpaper=""
while IFS= read -r f; do
    [ "$(basename "$f")" = "$sel_name" ] && wallpaper="$f" && break
done <<< "$wallpapers"

[ -z "$wallpaper" ] && notify-send "Wallpaper Picker" "File not found" && exit 1

feh --bg-fill "$wallpaper"
sed -i "s|^WALLPAPER=.*|WALLPAPER=$wallpaper|" "$local_cfg" 2>/dev/null || \
    echo "WALLPAPER=$wallpaper" >> "$local_cfg"
notify-send "Wallpaper" "$(basename "$wallpaper")"
