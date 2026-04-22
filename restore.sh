#!/bin/bash
set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

echo "==> Creating base directories..."
mkdir -p "$HOME/.config" "$HOME/Pictures/Wallpapers/h" "$HOME/Pictures/Wallpapers/v"

if command -v pacman >/dev/null 2>&1; then
    echo "==> Installing official packages..."
    sudo pacman -S --needed - < "$ROOT/packages/pkglist.txt"
else
    echo ">!< pacman not found, skipping official packages >!<"
fi

if command -v yay >/dev/null 2>&1; then
    if [ -f "$ROOT/packages/aurlist.txt" ]; then
        echo "==> Installing AUR packages..."
        yay -S --needed - < "$ROOT/packages/aurlist.txt"
    fi
else
    echo ">!< yay not found, skipping AUR packages >!<"
fi

echo "==> Working on Stow..."
for pkg in hypr waybar wofi kitty dunst fastfetch scripts; do
    stow "$pkg"
done
mkdir -p ~/Pictures/Wallpapers
cp -r wallpapers/Pictures/Wallpapers/h ~/Pictures/Wallpapers/
cp -r wallpapers/Pictures/Wallpapers/v ~/Pictures/Wallpapers/

echo "==> Restore complete"
echo "Extra details -> system/notes.md"
