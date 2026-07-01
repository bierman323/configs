#!/usr/bin/env bash
# Called by prefix+n via popup. Pick a zoxide directory, then what to launch.
# Runs inside a tmux popup (-E), so fzf has a terminal.
# All tmux operations target the parent session by name (not the popup pane).

SESSION=$(tmux display-message -p '#{session_name}')

# Enforce max pane count (9 Claude + 1 shell = 10)
PANE_COUNT=$(tmux list-panes -t "${SESSION}:1" 2>/dev/null | wc -l | tr -d ' ')
if [[ "$PANE_COUNT" -ge 10 ]]; then
    tmux display-message "Maximum panes reached (9 Claude + 1 shell)"
    exit 0
fi

# ── Step 1: Pick directory from zoxide ───────────────────────────────────────
CURRENT_DIR=$(tmux display-message -p '#{pane_current_path}')
ZOXIDE_LIST=$(zoxide query -l 2>/dev/null)
FULL_LIST=$(printf "%s\n%s" "$CURRENT_DIR" "$ZOXIDE_LIST" | awk '!seen[$0]++')

SELECTED_DIR=$(echo "$FULL_LIST" \
    | fzf --prompt="Directory > " \
          --height=100% \
          --border=none \
          --no-info \
          --header="Select directory, then choose launch type" \
          --color="header:#0099FF,prompt:#2EEDED,pointer:#2EEDED")

[[ -z "$SELECTED_DIR" ]] && exit 0
SELECTED_DIR="${SELECTED_DIR/#\~/$HOME}"

if [[ ! -d "$SELECTED_DIR" ]]; then
    tmux display-message "Directory not found: $SELECTED_DIR"
    exit 1
fi

SAFE_DIR=$(printf '%q' "$SELECTED_DIR")
PANE_LABEL=$(basename "$SELECTED_DIR")

# ── Step 2: Pick launch type ──────────────────────────────────────────────────
CHOICE=$(printf "Claude Code\nShell (zsh)\nCustom command" \
    | fzf --prompt="Launch > " \
          --height=6 \
          --border=rounded \
          --no-info \
          --header="$SELECTED_DIR" \
          --color="header:#888888,prompt:#2EEDED,pointer:#2EEDED")

[[ -z "$CHOICE" ]] && exit 0

case "$CHOICE" in
    "Claude Code")
        LAUNCH_CMD="cd ${SAFE_DIR} && claude --resume 2>/dev/null || claude"
        PANE_TITLE="${PANE_LABEL}"
        IS_SHELL=0
        ;;
    "Shell (zsh)")
        LAUNCH_CMD="cd ${SAFE_DIR}; exec zsh"
        PANE_TITLE="shell:${PANE_LABEL}"
        IS_SHELL=1
        ;;
    "Custom command")
        printf '\033[1mCommand:\033[0m '
        read -r CUSTOM_CMD
        [[ -z "$CUSTOM_CMD" ]] && exit 0
        LAUNCH_CMD="cd ${SAFE_DIR} && ${CUSTOM_CMD}"
        PANE_TITLE="$(echo "$CUSTOM_CMD" | cut -d' ' -f1)"
        IS_SHELL=0
        ;;
esac

# ── Create the pane in the parent session window 1 ───────────────────────────
NEW_PANE=$(tmux split-window -t "${SESSION}:1" -v -c "$SELECTED_DIR" -P -F '#{pane_id}' \
    "exec bash -c \"${LAUNCH_CMD}\"")

tmux select-pane -t "$NEW_PANE" -T "$PANE_TITLE"

~/.config/tmux-layouts/scripts/zoom-pane.sh
