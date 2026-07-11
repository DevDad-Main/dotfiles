#!/bin/bash

dim=$(echo -e "Always On\n2 minutes\n5 minutes\n10 minutes\n15 minutes\n30 minutes" | rofi -dmenu -p "Screen dims after" -i -selected-line 2)
[ -z "$dim" ] && exit 0

if [ "$dim" = "Always On" ]; then
  xset s off
  xset dpms 0 0 0
  killall xautolock 2>/dev/null
  notify-send "Screen" "Always on — no dim, no lock" -t 2000
  exit 0
fi

lock=$(echo -e "Don't lock\nLock after 5m\nLock after 10m\nLock after 15m\nLock after 30m" | rofi -dmenu -p "Auto-lock?" -i -selected-line 2)
[ -z "$lock" ] && exit 0

dim_min=${dim%% *}
dim_sec=$((dim_min * 60))
xset s "$dim_sec" "$dim_sec"
xset dpms "$dim_sec" "$((dim_sec + 10))" 0

killall xautolock 2>/dev/null

if [ "$lock" != "Don't lock" ]; then
  lock_min=${lock##* }
  lock_min=${lock%m}
  xautolock -time "$lock_min" -locker "$HOME/.config/i3/scripts/dim-then-lock.sh" &
fi

notify-send "Screen" "Dim after ${dim_min}m${lock_min:+ | Lock after ${lock_min}m}" -t 3000
