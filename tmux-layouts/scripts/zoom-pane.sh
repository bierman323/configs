#!/usr/bin/env bash
# Called by prefix+Enter. Promotes the focused Claude pane to the left 60% main column.
# Shell and scratch panes are never promoted.

CURRENT_WIN=$(tmux display-message -p '#{window_index}')
if [[ "$CURRENT_WIN" != "1" ]]; then
    exit 0
fi

SESSION=$(tmux display-message -p '#{session_name}')
CURRENT_PANE=$(tmux display-message -p '#{pane_id}')
CURRENT_TITLE=$(tmux display-message -p '#{pane_title}')
WIN_WIDTH=$(tmux display-message -p '#{window_width}')

# Never promote shell or scratch panes
if [[ "$CURRENT_TITLE" == shell* ]] || [[ "$CURRENT_TITLE" == scratch* ]]; then
    tmux display-message "Cannot promote shell/scratch pane"
    exit 0
fi

# Get all Claude panes (not shell/scratch) in window 1, ordered by index
TOP_PANES=$(tmux list-panes -t "${SESSION}:1" \
    -F '#{pane_id} #{pane_title}' \
    | awk '$2 !~ /^shell/ && $2 !~ /^scratch/ {print $1}')

MAIN_PANE=$(echo "$TOP_PANES" | head -1)
[[ -z "$MAIN_PANE" ]] && exit 0

# Already the main pane — check if width is already ~60%, do nothing if so
if [[ "$CURRENT_PANE" == "$MAIN_PANE" ]]; then
    CURRENT_WIDTH=$(tmux display-message -p '#{pane_width}')
    TARGET=$(( WIN_WIDTH * 60 / 100 ))
    DELTA=$(( CURRENT_WIDTH - TARGET ))
    [[ $DELTA -lt 0 ]] && DELTA=$(( -DELTA ))
    [[ $DELTA -le 3 ]] && exit 0
fi

# Swap focused pane into main (top-left) position if needed
if [[ "$CURRENT_PANE" != "$MAIN_PANE" ]]; then
    tmux swap-pane -s "$CURRENT_PANE" -t "$MAIN_PANE" -d
fi

# Re-apply main-vertical at 60% width
MAIN_WIDTH=$(( WIN_WIDTH * 60 / 100 ))
tmux select-layout -t "${SESSION}:1" main-vertical 2>/dev/null
tmux set-window-option -t "${SESSION}:1" main-pane-width "$MAIN_WIDTH" 2>/dev/null
