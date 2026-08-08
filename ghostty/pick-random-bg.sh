#!/bin/sh
# Picks a random image from ~/dotfiles/ghostty/images/test-tinted and
# writes a ghostty background config snippet for the next ghostty launch.
# The tinted dir is generated from images/test by tint-bg-images.py
# (multiply-blend with the Flexoki paper color); after adding new images
# to images/test, run: uv run ~/dotfiles/ghostty/tint-bg-images.py

set -e

IMAGES_DIR="$HOME/dotfiles/ghostty/images/test-tinted"
OUTPUT="$HOME/.config/ghostty/background.conf"
mkdir -p "$(dirname "$OUTPUT")"

chosen=$(
  find "$IMAGES_DIR" -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null \
  | awk 'BEGIN{srand()} {a[NR]=$0} END{if(NR>0)print a[int(rand()*NR)+1]}'
)

if [ -n "$chosen" ]; then
  cat > "$OUTPUT" <<EOF
background = fffcf0
background-image = $chosen
background-image-position = center
background-image-fit = contain
background-image-opacity = 0.4
EOF
  echo "ghostty background -> $(basename "$chosen")"
  echo "Reload with cmd+shift+, or open a new ghostty window."
fi
