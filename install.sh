#!/bin/bash
set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "Updating dependencies"
pacman -Qqe > "$ROOT/packages/pkglist.txt"
pacman -Qqem > "$ROOT/packages/aurlist.txt"

echo "Done."
