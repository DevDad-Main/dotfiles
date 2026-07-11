#!/bin/bash

current=$(brightnessctl g)
max=$(brightnessctl m)
for pct in 70 50 30 15 5; do
  val=$((max * pct / 100))
  brightnessctl s "$val" 2>/dev/null
  sleep 0.15
done

i3lock -n

brightnessctl s "$current" 2>/dev/null
