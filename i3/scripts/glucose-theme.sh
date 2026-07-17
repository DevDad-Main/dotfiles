#!/bin/bash
# Sync i3 theme colours to glucose-monitor config.json
CONFIG_DIR="$HOME/.config/glucose-monitor"
CONFIG_FILE="$CONFIG_DIR/config.json"
LOCAL_CFG="$HOME/.config/i3/config.local"

# Default catppuccin-mocha
BG="#1e1e2e"
FG="#cdd6f4"
ACCENT="#f9e2af"
LOW="#f38ba8"
HIGH="#fab387"
NORMAL="#a6e3a1"
MUTED="#585b70"
SURFACE="#313244"
BORDER="#585b70"

if [ -f "$LOCAL_CFG" ]; then
    source "$LOCAL_CFG"
    BG="${BAR_BG:-$BG}"
    FG="${BAR_FG:-$FG}"
    ACCENT="${WIN_FOCUSED:-$ACCENT}"
    LOW="${COLOR_CRITICAL:-$LOW}"
    HIGH="${COLOR_WARNING:-$HIGH}"
    NORMAL="${COLOR_GOOD:-$NORMAL}"
    MUTED="${WIN_DIM:-$MUTED}"
    SURFACE="${WIN_UNFOCUSED:-$SURFACE}"
    BORDER="${WIN_INACTIVE:-$BORDER}"
fi

mkdir -p "$CONFIG_DIR"

# Merge theme into existing config preserving credentials
if [ -f "$CONFIG_FILE" ]; then
    tmp=$(mktemp)
    python3 -c "
import json
with open('$CONFIG_FILE') as f:
    cfg = json.load(f)
cfg['theme'] = {
    'bg': '$BG',
    'fg': '$FG',
    'accent': '$ACCENT',
    'low': '$LOW',
    'high': '$HIGH',
    'normal': '$NORMAL',
    'muted': '$MUTED',
    'surface': '$SURFACE',
    'border': '$BORDER',
}
with open('$tmp', 'w') as f:
    json.dump(cfg, f, indent=2)
" && mv "$tmp" "$CONFIG_FILE"
else
    cat > "$CONFIG_FILE" <<EOF
{
  "theme": {
    "bg": "$BG",
    "fg": "$FG",
    "accent": "$ACCENT",
    "low": "$LOW",
    "high": "$HIGH",
    "normal": "$NORMAL",
    "muted": "$MUTED",
    "surface": "$SURFACE",
    "border": "$BORDER"
  }
}
EOF
fi
