#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# nvim
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim

# tmux
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf

# ghostty
mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config

# work mode: 前回モード（なければ coding）で背景・状態を初期化
"$DOTFILES_DIR/bin/workmode" "$(cat ~/.config/workmode 2>/dev/null || echo coding)"

# lazygit
mkdir -p ~/Library/Application\ Support/lazygit
ln -sf "$DOTFILES_DIR/lazygit/config.yml" ~/Library/Application\ Support/lazygit/config.yml

# tpm (tmux plugin manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "tpm installed. Run 'prefix + I' in tmux to install plugins."
fi

echo "dotfiles setup complete!"
