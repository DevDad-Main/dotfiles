#!/bin/bash
dots="$HOME/.config/dotfiles"
local_cfg="$dots/i3/config.local"

# List available themes from the themes directory (filter out image files)
themes_dir="$dots/i3/themes"
themes=$(ls "$themes_dir" 2>/dev/null | grep -vE '\.(png|jpg|jpeg|gif)$')
if [ -z "$themes" ]; then
    notify-send "Theme Picker" "No themes found in $themes_dir"
    exit 1
fi

# Build rofi entries with names
entries=""
for t in $themes; do
    name=$(grep "^THEME_NAME=" "$themes_dir/$t" 2>/dev/null | cut -d'"' -f2)
    [ -z "$name" ] && name="$t"
    entries="$entries$name ($t)\n"
done

# Show rofi menu
chosen=$(echo -e "$entries" | rofi -dmenu -i -p "  Theme  " -theme-str 'window {width: 320;} listview {lines: 6;}')
[ -z "$chosen" ] && exit 0

# Extract theme filename from the chosen entry
theme_file=$(echo "$chosen" | grep -oP '(?<=\()[^)]+(?=\))')
[ -z "$theme_file" ] && exit 1

# Source the theme file
source "$themes_dir/$theme_file"

# Update config.local with new theme values
cat > "$local_cfg" << EOF
# Per-machine overrides - edit freely, gitignored
BAR_FONT=$(grep "^BAR_FONT=" "$local_cfg" 2>/dev/null | cut -d= -f2 | tail -1)
BAR_FONT=${BAR_FONT:-10}
THEME=$theme_file
BAR_BG=$BAR_BG
BAR_FG=$BAR_FG
WIN_FOCUSED=$WIN_FOCUSED
WIN_INACTIVE=$WIN_INACTIVE
WIN_UNFOCUSED=$WIN_UNFOCUSED
WIN_URGENT=$WIN_URGENT
WIN_DIM=$WIN_DIM
COLOR_GOOD=$COLOR_GOOD
COLOR_WARNING=$COLOR_WARNING
COLOR_CRITICAL=$COLOR_CRITICAL
WALLPAPER=$WALLPAPER
KITTY_THEME=$KITTY_THEME
EMACS_THEME=$EMACS_THEME
CATPPUCCIN_FLAVOR=$CATPPUCCIN_FLAVOR
PICOM_FADING=$(grep "^PICOM_FADING=" "$local_cfg" 2>/dev/null | cut -d= -f2)
EOF

# Regenerate i3 config
bash "$dots/i3/generate.sh"

# Apply kitty theme
kitty_theme_file="$dots/kitty/themes/$KITTY_THEME.conf"
if [ -f "$kitty_theme_file" ]; then
    cp "$kitty_theme_file" "$dots/kitty/current-theme.conf"
    cp "$kitty_theme_file" "$HOME/.config/kitty/current-theme.conf"
    # Reload kitty config for all running instances
    pkill -x kitty --signal SIGUSR1 2>/dev/null
fi

# Set wallpaper
eval bg_file="$WALLPAPER"
if [ -f "$bg_file" ]; then
    feh --bg-fill "$bg_file"
fi

# Restart i3
i3-msg restart

notify-send "Theme Picker" "Switched to $THEME_NAME"
