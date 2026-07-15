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

# Save current theme's custom wallpaper before switching
# Save any custom wallpapers before truncating config.local
saved_custom_walls=$(grep "^CUSTOM_WALL_" "$local_cfg" 2>/dev/null)

current_theme=$(grep "^THEME=" "$local_cfg" 2>/dev/null | cut -d= -f2)
current_wall=$(grep "^WALLPAPER=" "$local_cfg" 2>/dev/null | head -1 | cut -d= -f2-)
theme_default_wall=$(grep "^WALLPAPER=" "$themes_dir/$current_theme" 2>/dev/null | cut -d= -f2- | sed "s|\$HOME|$HOME|")
if [ -n "$current_theme" ] && [ -n "$current_wall" ] && [ "$current_wall" != "$theme_default_wall" ]; then
    saved_custom_walls="$saved_custom_walls"$'\n'"CUSTOM_WALL_$current_theme=$current_wall"
fi

# Check for saved custom wallpaper for the new theme
custom_wall=$(echo "$saved_custom_walls" | grep "^CUSTOM_WALL_$theme_file=" | tail -1 | cut -d= -f2-)

# Preserve user overrides before the file is truncated
current_font=$(grep "^BAR_FONT=" "$local_cfg" 2>/dev/null | cut -d= -f2 | tail -1)
current_font=${current_font:-8}
current_fading=$(grep "^PICOM_FADING=" "$local_cfg" 2>/dev/null | cut -d= -f2)

# Update config.local with new theme values
cat > "$local_cfg" << EOF
# Per-machine overrides - edit freely, gitignored
BAR_FONT=$current_font
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
WALLPAPER=${custom_wall:-$WALLPAPER}
KITTY_THEME=$KITTY_THEME
EMACS_THEME=$EMACS_THEME
CATPPUCCIN_FLAVOR=$CATPPUCCIN_FLAVOR
PICOM_FADING=$current_fading
CASCADE_THEME=$CASCADE_THEME
EOF

# Restore saved custom wallpapers
[ -n "$saved_custom_walls" ] && echo "$saved_custom_walls" >> "$local_cfg"

# Write cascade-menu theme override (gitignored local config)
if [ -n "$CASCADE_THEME" ]; then
    mkdir -p "$HOME/.config/cascade-menu"
    cat > "$HOME/.config/cascade-menu/config.local" << EOF
[appearance]
theme = "$CASCADE_THEME"
EOF
fi

# Regenerate i3 config
bash "$dots/i3/generate.sh"

# Reload Emacs theme
emacsclient --eval '(load (expand-file-name "~/.config/dotfiles/emacs/theme.el"))' 2>/dev/null || true

# Apply kitty theme
kitty_theme_file="$dots/kitty/themes/$KITTY_THEME.conf"
if [ -f "$kitty_theme_file" ]; then
    cp "$kitty_theme_file" "$dots/kitty/current-theme.conf"
    cp "$kitty_theme_file" "$HOME/.config/kitty/current-theme.conf"
    # Reload kitty config for all running instances
    pkill -x kitty --signal SIGUSR1 2>/dev/null
fi

# Set wallpaper (use custom override if available)
eval bg_file="${custom_wall:-$WALLPAPER}"
if [ -f "$bg_file" ]; then
    feh --bg-fill "$bg_file"
fi

# Restart i3
i3-msg restart

notify-send "Theme Picker" "Switched to $THEME_NAME"
