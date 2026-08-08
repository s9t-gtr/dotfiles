#!/bin/sh
# Picks a random image from ~/dotfiles/ghostty/images/ink_painting-tinted
# and writes a ghostty background config snippet for the next ghostty
# launch. The tinted dir is generated from images/ink_painting by
# tint-bg-images.py (background color remapped to the Flexoki paper
# color); after adding new images to images/ink_painting, run:
#   uv run ~/dotfiles/ghostty/tint-bg-images.py

set -e

IMAGES_DIR="$HOME/dotfiles/ghostty/images/ink_painting-tinted"
OUTPUT="$HOME/.config/ghostty/background.conf"
mkdir -p "$(dirname "$OUTPUT")"

chosen=$(
  find "$IMAGES_DIR" -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null \
  | awk 'BEGIN{srand()} {a[NR]=$0} END{if(NR>0)print a[int(rand()*NR)+1]}'
)

if [ -n "$chosen" ]; then
  cat > "$OUTPUT" <<EOF
background-image = $chosen
background-image-position = center
background-image-fit = contain
background-image-opacity = 0.4
EOF
  echo "ghostty background -> $(basename "$chosen")"
  echo "Reload with cmd+shift+, or open a new ghostty window."
fi
