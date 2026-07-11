#!/bin/bash

internal_card="alsa_card.pci-0000_00_1f.3"
items=""

# Internal card output profiles — skip +input variants and stereo-only
while IFS= read -r line; do
  name=$(echo "$line" | grep -oP '^\s+\K\S+(?=:\s)')
  desc=$(echo "$line" | grep -oP '^\s+\S+:\s+\K.*(?=\s*\(sinks:)' | xargs)
  [ "$name" = "off" ] && continue
  [[ "$name" != output:* ]] && continue
  [[ "$name" == *+input:* ]] && continue
  [[ "$name" == *hdmi-surround71* ]] && continue
  [[ "$name" == *hdmi-surround* ]] && continue
  case "$name" in
    output:analog-stereo)     label="Headphones / Speakers" ;;
    output:hdmi-stereo)       label="HDMI (TV)" ;;
    pro-audio)                continue ;;
    *)                        label="$desc" ;;
  esac
  items+="$label (profile:$name)"$'\n'
done < <(pactl list cards | sed -n "/$internal_card/,/^$/p" | sed -n '/Profiles:/,/Ports:/p' | grep "available: yes")

# Bluetooth / USB sinks on other cards
while IFS= read -r line; do
  sid=$(echo "$line" | awk '{print $1}')
  desc=$(pactl list sinks | sed -n "/Sink #$sid/,/^$/p" | grep "Description:" | sed 's/.*Description: //')
  card=$(pactl list sinks | sed -n "/Sink #$sid/,/^$/p" | grep "api.alsa.card.name" | sed 's/.*"\(.*\)"/\1/')
  [[ -n "$card" ]] && continue
  items+="$desc (sink:$sid)"$'\n'
done < <(pactl list short sinks 2>/dev/null)

selected=$(echo "$items" | sed '/^$/d' | rofi -dmenu -p "Audio Output" -i)
[ -z "$selected" ] && exit 0

kind=$(echo "$selected" | grep -oP '\((profile|sink):[^)]+\)')
key=$(echo "$kind" | grep -oP '[^:)]+$')

if echo "$kind" | grep -q "profile:"; then
  pactl set-card-profile "$internal_card" "$key"
  sleep 0.3
  new_sink=$(pactl list short sinks | head -1 | awk '{print $2}')
else
  new_sink=$(pactl list short sinks | awk -v id="$key" '$1 == id {print $2}')
fi

[ -n "$new_sink" ] && pactl set-default-sink "$new_sink"

pactl list short sink-inputs 2>/dev/null | awk '{print $1}' | while read -r id; do
  pactl move-sink-input "$id" "$new_sink" 2>/dev/null
done

label=$(echo "$selected" | sed 's/\s*(profile:.*)//;s/\s*(sink:.*)//')
notify-send "Audio Output" "Switched to $label" -t 2000
