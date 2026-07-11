#!/bin/bash

power_profile=$(powerprofilesctl get)

entries="  Shutdown\n  Reboot\n  Lock\n  Logout\n  Suspend\n  Power: $power_profile"

chosen=$(echo -e "$entries" | rofi -dmenu -p "  " -theme-str 'window {width: 220;} listview {lines: 6;}')

case "$chosen" in
  *Shutdown) systemctl poweroff ;;
  *Reboot)   systemctl reboot ;;
  *Lock)     i3lock --blur 5 ;;
  *Logout)   i3-msg exit ;;
  *Suspend)  systemctl suspend ;;
  *Power:*)
    case "$power_profile" in
      performance) powerprofilesctl set balanced ;;
      balanced)    powerprofilesctl set power-saver ;;
      power-saver) powerprofilesctl set performance ;;
    esac ;;
esac
