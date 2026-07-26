#!/bin/bash

local_cfg="$HOME/.config/dotfiles/i3/config.local"
[ -f "$local_cfg" ] && source "$local_cfg"

if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
  read w h <<< $(identify -format "%w %h" "$WALLPAPER" 2>/dev/null)
  if [ "$h" -gt "$w" ]; then
    feh --bg-center --image-bg black "$WALLPAPER"
  else
    feh --bg-fill "$WALLPAPER"
  fi
  exit 0
fi

theme="${THEME:-gruber-darker}"
theme_dir="$HOME/.config/dotfiles/i3/themes/wallpapers/$theme"

if [ -f "$theme_dir/asia-art.jpg" ]; then
  feh --bg-center --image-bg black "$theme_dir/asia-art.jpg"
elif [ -f "$theme_dir/mona-lisa-ascii.jpg" ]; then
  feh --bg-center --image-bg black "$theme_dir/mona-lisa-ascii.jpg"
else
  feh --bg-fill "$theme_dir/creation-of-adam.jpeg"
fi
