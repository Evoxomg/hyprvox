#!/usr/bin/env bash

choice=$(printf "󰃰 Calendar\n󰅍 Clipboard\n Volume\n󰃠 Lock\n󰍃 Logout\n Reboot\n Shutdown" \
| wofi --dmenu --width 420 --height 500 --prompt "Control Center")

case "$choice" in
  *Calendar*)
    kitty --title calendar -e sh -c "cal -3; read"
    ;;
  *Clipboard*)
    cliphist list | wofi --dmenu | cliphist decode | wl-copy
    ;;
  *Volume*)
    pavucontrol
    ;;
  *Lock*)
    hyprlock
    ;;
  *Logout*)
    hyprctl dispatch exit
    ;;
  *Reboot*)
    systemctl reboot
    ;;
  *Shutdown*)
    systemctl poweroff
    ;;
esac
