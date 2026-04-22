#!/usr/bin/env bash

choice=$(printf "Lock\nLogout\nReboot\nShutdown" | wofi --dmenu --prompt "Power" --width 400 --height 250)

case "$choice" in
    Lock)
        hyprlock
        ;;
    Logout)
        hyprctl dispatch exit
        ;;
    Reboot)
        systemctl reboot
        ;;
    Shutdown)
        systemctl poweroff
        ;;
esac
