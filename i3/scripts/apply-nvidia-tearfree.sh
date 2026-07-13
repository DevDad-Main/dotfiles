#!/bin/bash
# Apply NVIDIA ForceFullCompositionPipeline to fix screen tearing on X11.
# Safe to run on any machine — the config only matches NVIDIA GPUs.
# Run once, then log out and back in (or restart X).

set -euo pipefail

CONFIG="/etc/X11/xorg.conf.d/10-nvidia-tearfree.conf"

if [ -f "$CONFIG" ]; then
    echo "✓ Tear-free config already exists at $CONFIG"
    cat "$CONFIG"
    exit 0
fi

echo "Creating $CONFIG ..."

sudo tee "$CONFIG" << 'EOF'
Section "Device"
    Identifier "NVIDIA Card"
    Driver "nvidia"
    Option "ForceFullCompositionPipeline" "on"
EndSection
EOF

echo ""
echo "Done. Log out and back in (or restart X) for it to take effect."
