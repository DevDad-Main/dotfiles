#!/bin/bash
local_cfg="$HOME/.config/dotfiles/i3/config.local"

if [ ! -f "$local_cfg" ]; then
    echo 'BAR_FONT=10' > "$local_cfg"
fi

source "$local_cfg"
BAR_FONT=${BAR_FONT:-10}

# Fix empty BAR_FONT in file
grep -q '^BAR_FONT=$' "$local_cfg" && sed -i 's/^BAR_FONT=$/BAR_FONT=10/' "$local_cfg"

case "$1" in
  +) new=$((BAR_FONT + 1)) ;;
  -) new=$((BAR_FONT - 1)) ;;
  *) echo "usage: bar_font.sh {+|-}"; exit 1 ;;
esac

if [ "$new" -lt 6 ] || [ "$new" -gt 20 ]; then exit 1; fi

sed -i "s/^BAR_FONT=${BAR_FONT}$/BAR_FONT=${new}/" "$local_cfg"
bash "$HOME/.config/dotfiles/i3/generate.sh"
i3-msg restart
