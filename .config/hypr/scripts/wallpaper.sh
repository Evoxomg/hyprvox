#!/bin/bash


DIR_HORIZ="$HOME/Pictures/Wallpapers/h"
DIR_VERT="$HOME/Pictures/Wallpapers/v"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

MONITOR_HORIZ="DP-1"
MONITOR_VERT="DP-2"


CHOICE=$(echo -e "Horizontal\nVertical" | wofi --dmenu --prompt "Monitor?" --width 300 --height 165)
[[ -z "$CHOICE" ]] && exit

if [ "$CHOICE" == "Horizontal" ]; then
    SEL_DIR="$DIR_HORIZ"
    TARGET_MONITOR="$MONITOR_HORIZ"
    OTHER_MONITOR="$MONITOR_VERT"
else
    SEL_DIR="$DIR_VERT"
    TARGET_MONITOR="$MONITOR_VERT"
    OTHER_MONITOR="$MONITOR_HORIZ"
fi


CURRENT_H=$(grep -A 3 "monitor = $MONITOR_HORIZ" "$CONFIG_FILE" | grep "path =" | cut -d'=' -f2 | xargs)
CURRENT_V=$(grep -A 3 "monitor = $MONITOR_VERT" "$CONFIG_FILE" | grep "path =" | cut -d'=' -f2 | xargs)


SELECTED_WALL=$(ls "$SEL_DIR" | wofi --dmenu -i \
    --prompt "Choose a wallpaper ($CHOICE)" \
    --width 300 \
    --height 300 \
    -preview-cmd "hyprctl hyprpaper preload \"$SEL_DIR/{}\" && hyprctl hyprpaper wallpaper \"$TARGET_MONITOR,$SEL_DIR/{}\"")

[[ -z "$SELECTED_WALL" ]] && exit

NEW_PATH=$(realpath "$SEL_DIR/$SELECTED_WALL")

# Definir o que escrever para cada monitor
if [ "$CHOICE" == "Horizontal" ]; then
    WALL_H="$NEW_PATH"
    WALL_V="$CURRENT_V"
else
    WALL_H="$CURRENT_H"
    WALL_V="$NEW_PATH"
fi

cat <<EOF > "$CONFIG_FILE"
ipc = on

wallpaper {
    monitor = $MONITOR_HORIZ
    path = $WALL_H
    fit_mode = cover
}

wallpaper {
    monitor = $MONITOR_VERT
    path = $WALL_V
    fit_mode = cover
}
EOF

pkill hyprpaper
hyprpaper &

notify-send "Wallpaper" "Set to $SELECTED_WALL"
