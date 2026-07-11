#!/bin/bash
dir="$(cd "$(dirname "$0")" && pwd)"
local_cfg="$dir/config.local"

BAR_FONT=10
if [ -f "$local_cfg" ]; then
    source "$local_cfg"
fi

sed "s/@@BAR_FONT@@/$BAR_FONT/g" "$dir/config.base" > "$dir/config"
