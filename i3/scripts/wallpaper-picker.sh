#!/bin/bash
dots="$HOME/.config/dotfiles"
local_cfg="$dots/i3/config.local"

feh --thumbnails --scale-down \
    --action "sh -c 'feh --bg-fill \"\$1\"; \
        grep -q \"^WALLPAPER=\" \"$local_cfg\" 2>/dev/null && \
        sed -i \"s|^WALLPAPER=.*|WALLPAPER=\$1|\" \"$local_cfg\" || \
        echo \"WALLPAPER=\$1\" >> \"$local_cfg\"; \
        notify-send \"Wallpaper\" \"Set to \$(basename \"\$1\")\"' _" \
    "$dots/i3/themes/wallpapers"/*/
