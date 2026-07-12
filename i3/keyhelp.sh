#!/bin/bash
entries="\
$mod+Return        Terminal (kitty)
$mod+d             App launcher (rofi)
$mod+Shift+d       Command runner
$mod+Shift+Return  File manager (thunar)
$mod+q             Close window
$mod+h/j/k/l       Focus left/down/up/right
$mod+Shift+h/j/k/l Move window
$mod+1-0           Switch workspace
$mod+Shift+1-0     Move window to workspace
$mod+y             Toggle split direction
$mod+Shift+y       Reset to horizontal split
$mod+s             Stacking layout
$mod+w             Tabbed layout
$mod+Space         Toggle floating
$mod+f             Toggle fullscreen
$mod+r             Resize mode (h/j/k/l)
$mod+Shift+r       Restart i3
$mod+Shift+e       Exit i3
$mod+Ctrl+q        Power menu (shutdown/reboot/lock)
$mod+b             Bluetooth (bluetui)
$mod+g             Git (lazygit)
$mod+o             Audio output (wiremix)
$mod+Escape        Lock screen
$mod+Shift+Escape  Screen dim/lock settings
$mod+Shift+t       Theme picker
$mod+Ctrl+equal/+  Increase bar font
$mod+Ctrl+minus/-  Decrease bar font
$mod+Shift+s       Region screenshot (clipboard)
$mod+Print         Fullscreen screenshot (clipboard)
Print              Fullscreen screenshot (file)
$mod+minus         Move to scratchpad
$mod+equal         Show scratchpad
$mod+grave         Focus parent
Super+Shift+b      Toggle bar
XF86AudioRaiseVol  Volume up
XF86AudioLowerVol  Volume down
XF86AudioMute      Mute toggle
XF86MonBrightness  Brightness up/down
XF86AudioPlay      Play/Pause
XF86AudioNext      Next track
XF86AudioPrev      Previous track"

echo "$entries" | rofi -dmenu -i -p "  Keybinds  " \
  -theme-str 'window {width: 640;} listview {lines: 20; spacing: 4px;} element {padding: 4px 8px;}'
