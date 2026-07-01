#!/usr/bin/env bash
# Called by prefix+i. Jumps to the next pane waiting for input.

SESSION=$(tmux display-message -p '#{session_name}')
CURRENT_PANE=$(tmux display-message -p '#{pane_id}')

# Get all panes ordered by pane_index
mapfile -t ALL_PANES < <(tmux list-panes -a -F '#{pane_id}' 2>/dev/null)

WAITING_PANES=()
for PANE_ID in "${ALL_PANES[@]}"; do
    IS_WAITING=$(tmux show-option -pv -t "$PANE_ID" @waiting 2>/dev/null)
    if [[ "$IS_WAITING" == "1" ]]; then
        WAITING_PANES+=("$PANE_ID")
    fi
done

if [[ ${#WAITING_PANES[@]} -eq 0 ]]; then
    tmux display-message "No panes waiting for input"
    exit 0
fi

# Find position of current pane in waiting list
NEXT_PANE="${WAITING_PANES[0]}"
for i in "${!WAITING_PANES[@]}"; do
    if [[ "${WAITING_PANES[$i]}" == "$CURRENT_PANE" ]]; then
        NEXT_IDX=$(( (i + 1) % ${#WAITING_PANES[@]} ))
        NEXT_PANE="${WAITING_PANES[$NEXT_IDX]}"
        break
    fi
done

tmux switch-client -t "$NEXT_PANE" 2>/dev/null || tmux select-pane -t "$NEXT_PANE"
