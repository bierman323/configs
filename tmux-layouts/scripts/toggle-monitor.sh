#!/usr/bin/env bash
# Called by prefix+m. Toggles @monitor_mode on/off.

CURRENT=$(tmux show-option -gv @monitor_mode 2>/dev/null)

if [[ "$CURRENT" == "on" ]]; then
    tmux set-option -g @monitor_mode "off"
    # Strip ⚡ prefixes from all pane titles
    while read -r LINE; do
        PANE_ID="${LINE%% *}"
        PANE_TITLE="${LINE#* }"
        [[ -z "$PANE_ID" ]] && continue
        CLEAN_TITLE=$(echo "$PANE_TITLE" | sed 's/^⚡ //')
        tmux select-pane -t "$PANE_ID" -T "$CLEAN_TITLE" 2>/dev/null
    done < <(tmux list-panes -a -F '#{pane_id} #{pane_title}' 2>/dev/null)
    tmux display-message "[FOCUS] mode — indicators off"
else
    tmux set-option -g @monitor_mode "on"
    tmux display-message "[MONITOR] mode — watching for input"
    # Immediately run check-waiting to show current state
    ~/.config/tmux-layouts/scripts/check-waiting.sh
fi
