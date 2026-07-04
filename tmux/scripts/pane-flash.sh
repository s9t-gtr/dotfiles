#!/usr/bin/env bash
# tmux run-shell の PATH は最小で /opt/homebrew/bin を含まないため補う（tmux 127 対策）
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
tmux set -w window-active-style "bg=#333333"
sleep 0.05 && tmux set -w window-active-style ''
