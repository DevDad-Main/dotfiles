#!/usr/bin/env bash
# Fuzzy pick a directory, then launch Neovide in it

dir=$(fd . ~ --type d --max-depth 3 --hidden --exclude .git | \
  fzf --height 40% --border --layout=reverse --prompt="Select directory > ")

if [ -n "$dir" ]; then
  neovide "$dir"
fi
