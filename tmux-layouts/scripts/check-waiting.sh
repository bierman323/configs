#!/usr/bin/env bash
# Run via status-interval. Detects Claude input-waiting state per pane.
# Sets pane user option @waiting. Updates title prefix when monitor mode is on.

SESSION=$(tmux display-message -p '#{session_name}' 2>/dev/null)
[[ -z "$SESSION" ]] && exit 0

MONITOR_MODE=$(tmux show-option -gv @monitor_mode 2>/dev/null)
WAITING_COUNT=0

while read -r LINE; do
    PANE_ID="${LINE%% *}"
    PANE_TITLE="${LINE#* }"
    [[ -z "$PANE_ID" ]] && continue

    # Capture last 15 lines of pane output
    CONTENT=$(tmux capture-pane -t "$PANE_ID" -p 2>/dev/null | tail -15)

    # Detect Claude waiting state:
    # 1. Tool confirmation dialogs (Allow/Deny prompts)
    # 2. Idle at input prompt (❯ visible) but NOT actively running a task
    IS_WAITING=0
    if echo "$CONTENT" | grep -qE '(\? \(y/n\)|\? \[Y/n\]|\? \[y/N\]|\(y/N\)|❯ No|❯ Yes|Allow\?|Deny\?)'; then
        IS_WAITING=1
    elif echo "$CONTENT" | grep -qE '^❯\s*$' && ! echo "$CONTENT" | grep -qE '(Running…|⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏|Thinking|tokens/sec)'; then
        IS_WAITING=1
    fi

    # Set pane user option (-p flag for pane-scoped option)
    tmux set-option -p -t "$PANE_ID" @waiting "$IS_WAITING" 2>/dev/null

    # Update title prefix based on mode
    BASE_TITLE=$(echo "$PANE_TITLE" | sed 's/^⚡ //')

    if [[ "$IS_WAITING" == "1" ]]; then
        WAITING_COUNT=$(( WAITING_COUNT + 1 ))
        if [[ "$MONITOR_MODE" == "on" ]]; then
            tmux select-pane -t "$PANE_ID" -T "⚡ ${BASE_TITLE}" 2>/dev/null
        fi
    else
        # Remove prefix if present
        if [[ "$MONITOR_MODE" == "on" ]]; then
            tmux select-pane -t "$PANE_ID" -T "$BASE_TITLE" 2>/dev/null
        fi
    fi
done < <(tmux list-panes -a -F '#{pane_id} #{pane_title}' 2>/dev/null)

# Store waiting count for status bar
tmux set-option -g @waiting_count "$WAITING_COUNT" 2>/dev/null
