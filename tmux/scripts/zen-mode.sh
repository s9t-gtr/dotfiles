#!/usr/bin/env bash

is_zen=$(tmux show-option -w -v @zen_mode 2>/dev/null)

if [ "$is_zen" = "on" ]; then
    tmux kill-pane -a
    tmux set-option -w @zen_mode "off"
else
    pane_count=$(tmux display-message -p '#{window_panes}')
    if [ "$pane_count" -gt 1 ]; then
        tmux display-message "Zen Mode: window already has multiple panes — aborted"
        exit 1
    fi

    window_width=$(tmux display-message -p '#{window_width}')
    side_width=$((window_width * 25 / 100))

    tmux split-window -h -l "$side_width" 'cat'
    tmux select-pane -t :.+
    tmux split-window -h -b -l "$side_width" 'cat'
    tmux select-pane -t :.+

    tmux set-option -w @zen_mode "on"
fi
