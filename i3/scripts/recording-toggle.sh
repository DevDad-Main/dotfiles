#!/usr/bin/env bash
export DISPLAY=:0
PIDFILE="/tmp/glucose-recording.pid"

if [ -f "$PIDFILE" ]; then
    pid=$(cat "$PIDFILE")
    kill "$pid" 2>/dev/null
    rm -f "$PIDFILE"
    notify-send -u normal "Recording" "Stopped"
    exit 0
fi

notify-send -u low "Recording" "Select a region…"
sleep 0.3

region=$(slop -f "%x %y %w %h" 2>/dev/null) || {
    notify-send -u low "Recording" "Cancelled"
    exit 1
}

read -r x y w h <<< "$region"

out="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H.%M.%S).mp4"
ffmpeg -y -f x11grab -s "${w}x${h}" -i ":0.0+$x,$y" -r 30 "$out" &
pid=$!
echo "$pid" > "$PIDFILE"
notify-send -u low "Recording" "Started → $(basename "$out")"
