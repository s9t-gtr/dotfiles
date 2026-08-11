#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Jump to Secretary
# @raycast.mode silent
# @raycast.icon 🤖
# @raycast.packageName tmux

# Ghosttyを前面に出し、tmuxクライアントを秘書セッション(obsidian)へ切り替える
open -a Ghostty

client="$(tmux list-clients -F '#{client_name}' 2>/dev/null | head -1)"
if [ -n "$client" ]; then
  tmux switch-client -c "$client" -t obsidian
else
  # クライアントがいない = Ghosttyが今起動したばかり。attach側(ghostty config)がobsidianに繋がるのを待つ手はないので何もしない
  exit 0
fi
