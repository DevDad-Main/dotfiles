#!/bin/bash
tmp=$(mktemp /tmp/keybinds-XXXX)
cat > "$tmp" << 'EOF'
Mod+Return        ·  Terminal (kitty)
Mod+d             ·  App launcher (rofi)
Mod+Shift+d       ·  Command runner
Mod+Shift+Return  ·  File manager (thunar)
Mod+q             ·  Close window
Mod+h/j/k/l       ·  Focus left/down/up/right
Mod+Shift+h/j/k/l ·  Move window
Mod+1-0           ·  Switch workspace
Mod+Shift+1-0     ·  Move window to workspace
Mod+y             ·  Toggle split direction
Mod+Shift+y       ·  Reset to horizontal split
Mod+s             ·  Stacking layout
Mod+w             ·  Tabbed layout
Mod+Space         ·  Toggle floating
Mod+f             ·  Toggle fullscreen
Mod+r             ·  Resize mode (h/j/k/l)
Mod+Shift+r       ·  Restart i3
Mod+Shift+e       ·  Exit i3
Mod+Ctrl+q        ·  Power menu
Mod+b             ·  Bluetooth
Mod+g             ·  Git (lazygit)
Mod+o             ·  Audio output
Mod+Escape        ·  Lock screen
Mod+Shift+Escape  ·  Screen dim/lock settings
Mod+Slash         ·  Show this help
Mod+Shift+t       ·  Theme picker
Mod+Ctrl+equal    ·  Increase bar font
Mod+Ctrl+minus    ·  Decrease bar font
Mod+Shift+s       ·  Region screenshot
Mod+Print         ·  Fullscreen screenshot
Print             ·  Screenshot to file
Mod+minus         ·  Move to scratchpad
Mod+equal         ·  Show scratchpad
Mod+grave         ·  Focus parent
Super+Shift+b     ·  Toggle bar
Volume keys       ·  Volume up/down/mute
Brightness keys   ·  Brightness up/down
Media keys        ·  Play/Pause/Next/Prev
EOF
kitty --class keyhelp -o font_size=13 sh -c "fzf --no-info --bind=esc:abort,enter:abort < '$tmp'"
rm -f "$tmp"
