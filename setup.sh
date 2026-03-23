#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# nvim
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim

# tmux
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf

# tpm (tmux plugin manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "tpm installed. Run 'prefix + I' in tmux to install plugins."
fi

echo "dotfiles setup complete!"
