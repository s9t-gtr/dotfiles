#!/usr/bin/env bash
# tmux run-shell の PATH は最小で /opt/homebrew/bin を含まないため補う（tmux 127 対策）
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
# zen: 白磁の上に水色(瓶覗〜水色 #cfe7f0)をひと刷毛。選択範囲と同じ色で透過感を出す
tmux set -w window-active-style "bg=#cfe7f0"
sleep 0.05 && tmux set -w window-active-style ''
