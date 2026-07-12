#!/bin/bash
dir="$(cd "$(dirname "$0")" && pwd)"
local_cfg="$dir/config.local"

# Defaults
BAR_FONT=10
BAR_BG=#1c1f20
BAR_FG=#ebdbb2
WIN_FOCUSED=#d79921
WIN_INACTIVE=#504945
WIN_UNFOCUSED=#3c3836
WIN_URGENT=#cc241d
WIN_DIM=#a89984
WALLPAPER=$HOME/.config/dotfiles/i3/gruv-rocket.png

if [ -f "$local_cfg" ]; then
    source "$local_cfg"
fi

sed -e "s|@@BAR_FONT@@|$BAR_FONT|g" \
    -e "s|@@BAR_BG@@|$BAR_BG|g" \
    -e "s|@@BAR_FG@@|$BAR_FG|g" \
    -e "s|@@WIN_FOCUSED@@|$WIN_FOCUSED|g" \
    -e "s|@@WIN_INACTIVE@@|$WIN_INACTIVE|g" \
    -e "s|@@WIN_UNFOCUSED@@|$WIN_UNFOCUSED|g" \
    -e "s|@@WIN_URGENT@@|$WIN_URGENT|g" \
    -e "s|@@WIN_DIM@@|$WIN_DIM|g" \
    -e "s|@@WALLPAPER@@|$WALLPAPER|g" \
    "$dir/config.base" > "$dir/config"

# Generate i3status-rust config
sed -e "s|@@BAR_BG@@|$BAR_BG|g" \
    -e "s|@@BAR_FG@@|$BAR_FG|g" \
    -e "s|@@COLOR_GOOD@@|${COLOR_GOOD:-$BAR_FG}|g" \
    -e "s|@@COLOR_WARNING@@|${COLOR_WARNING:-#d79921}|g" \
    -e "s|@@COLOR_CRITICAL@@|${COLOR_CRITICAL:-#cc241d}|g" \
    "$dir/../i3status-rust/config.base.toml" > "$dir/../i3status-rust/config.toml"

# Generate rofi config
sed -e "s|@@BAR_BG@@|$BAR_BG|g" \
    -e "s|@@BAR_FG@@|$BAR_FG|g" \
    -e "s|@@WIN_FOCUSED@@|$WIN_FOCUSED|g" \
    -e "s|@@WIN_UNFOCUSED@@|$WIN_UNFOCUSED|g" \
    -e "s|@@WIN_DIM@@|$WIN_DIM|g" \
    -e "s|@@WIN_URGENT@@|$WIN_URGENT|g" \
    "$dir/../rofi/config.base.rasi" > "$dir/../rofi/config.rasi" 2>/dev/null

# Copy rofi config to ~/.config/rofi (use temp file to avoid hardlink collision)
cp "$dir/../rofi/config.rasi" "$HOME/.config/rofi/config.rasi" 2>/dev/null || true
