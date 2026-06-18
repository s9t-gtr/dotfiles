#!/bin/sh
# Picks a random image from ~/Documents/ghostty/images and writes
# a ghostty background config snippet for the next ghostty launch.

set -e

IMAGES_DIR="$HOME/dotfiles/ghostty/images"
OUTPUT="$HOME/.config/ghostty/background.conf"
mkdir -p "$(dirname "$OUTPUT")"

chosen=$(
  find "$IMAGES_DIR" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null \
  | awk 'BEGIN{srand()} {a[NR]=$0} END{if(NR>0)print a[int(rand()*NR)+1]}'
)

if [ -n "$chosen" ]; then
  cat > "$OUTPUT" <<EOF
background-image = $chosen
background-image-position = center
background-image-fit = cover
background-image-opacity = 0.1
EOF
  echo "ghostty background -> $(basename "$chosen")"
  echo "Reload with cmd+shift+, or open a new ghostty window."
fi
