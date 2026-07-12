#!/bin/bash
rofi -dmenu -markup -i -p "  Keybinds  " \
  -theme-str 'window {width: 800;} listview {lines: 20; spacing: 4px;}' \
  -theme-str 'element {horizontal-align: 0;}' << 'EOF'
<tt>Mod+Return        </tt> ·  Terminal (kitty)
<tt>Mod+d             </tt> ·  App launcher (rofi)
<tt>Mod+Shift+d       </tt> ·  Command runner
<tt>Mod+Shift+Return  </tt> ·  File manager (thunar)
<tt>Mod+q             </tt> ·  Close window
<tt>Mod+h/j/k/l       </tt> ·  Focus left/down/up/right
<tt>Mod+Shift+h/j/k/l </tt> ·  Move window
<tt>Mod+1-0           </tt> ·  Switch workspace
<tt>Mod+Shift+1-0     </tt> ·  Move window to workspace
<tt>Mod+y             </tt> ·  Toggle split direction
<tt>Mod+Shift+y       </tt> ·  Reset to horizontal split
<tt>Mod+s             </tt> ·  Stacking layout
<tt>Mod+w             </tt> ·  Tabbed layout
<tt>Mod+Space         </tt> ·  Toggle floating
<tt>Mod+f             </tt> ·  Toggle fullscreen
<tt>Mod+r             </tt> ·  Resize mode (h/j/k/l)
<tt>Mod+Shift+r       </tt> ·  Restart i3
<tt>Mod+Shift+e       </tt> ·  Exit i3
<tt>Mod+Ctrl+q        </tt> ·  Power menu
<tt>Mod+b             </tt> ·  Bluetooth
<tt>Mod+g             </tt> ·  Git (lazygit)
<tt>Mod+o             </tt> ·  Audio output
<tt>Mod+Escape        </tt> ·  Lock screen
<tt>Mod+Shift+Escape  </tt> ·  Screen dim/lock settings
<tt>Mod+Slash         </tt> ·  Show this help
<tt>Mod+Shift+t       </tt> ·  Theme picker
<tt>Mod+Ctrl+equal    </tt> ·  Increase bar font
<tt>Mod+Ctrl+minus    </tt> ·  Decrease bar font
<tt>Mod+Shift+s       </tt> ·  Region screenshot
<tt>Mod+Print         </tt> ·  Fullscreen screenshot
<tt>Print             </tt> ·  Screenshot to file
<tt>Mod+minus         </tt> ·  Move to scratchpad
<tt>Mod+equal         </tt> ·  Show scratchpad
<tt>Mod+grave         </tt> ·  Focus parent
<tt>Super+Shift+b     </tt> ·  Toggle bar
<tt>Volume keys       </tt> ·  Volume up/down/mute
<tt>Brightness keys   </tt> ·  Brightness up/down
<tt>Media keys        </tt> ·  Play/Pause/Next/Prev
EOF
