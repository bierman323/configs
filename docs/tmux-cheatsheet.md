---
tags: [cheatsheet, tmux, tools]
aliases: [tmux keys, tmux reference]
---

# tmux Cheatsheet

[tmux docs](https://github.com/tmux/tmux/wiki) | [Config](https://github.com/tmux/tmux/wiki/Getting-Started#configuring-tmux) | [man page](https://man7.org/linux/man-pages/man1/tmux.1.html)

> **Prefix**: `Ctrl-Space` (remapped from default `Ctrl-b`)
> Config: `~/.tmux.conf` (symlinked from `~/.config/dotfiles/.tmux.conf`)
> All keybindings below assume prefix first unless noted otherwise.

---

## Sessions

| Key | Action |
|-----|--------|
| `tmux new -s name` | New named session (shell) |
| `tmux ls` | List sessions (shell) |
| `tmux a -t name` | Attach to session (shell) |
| `tmux kill-session -t name` | Kill session (shell) |
| `d` | Detach from session |
| `s` | List/switch sessions (interactive) |
| `$` | Rename session |
| `(` / `)` | Previous / next session |

---

## Windows

| Key | Action |
|-----|--------|
| `c` | New window |
| `,` | Rename window |
| `&` | Kill window (confirm) |
| `w` | List windows (interactive) |
| `0-9` | Jump to window by number |
| **`Ctrl-h`** | Previous window |
| **`Ctrl-l`** | Next window |
| `p` / `n` | Previous / next window (default) |
| `l` | Last active window |
| `.` | Move window to new index |

> Windows start at index **1** (not 0). Auto-renumbered on close.
> Window auto-rename is **disabled** (`allow-rename off`).

---

## Panes

### Navigation (vim-style, repeatable)

| Key | Action |
|-----|--------|
| **`h`** | Move left |
| **`j`** | Move down |
| **`k`** | Move up |
| **`l`** | Move right |

> These are **repeatable** within 1 second -- no need to re-press prefix.

### Split & Manage

| Key | Action |
|-----|--------|
| `"` | Split horizontal (opens in current path) |
| `%` | Split vertical (opens in current path) |
| `x` | Kill pane (confirm) |
| `z` | Toggle pane zoom (fullscreen) |
| `!` | Break pane into new window |
| `q` | Show pane numbers (type number to jump) |
| `{` / `}` | Swap pane left / right |
| `Space` | Cycle through layouts |

### Resize

| Key | Action |
|-----|--------|
| `Ctrl-Arrow` | Resize pane (fine, 1 cell) |
| `Alt-Arrow` | Resize pane (coarse, 5 cells) |

> Pane titles shown in **top border** (`pane-border-status top`).

---

## Copy Mode (vi keys)

> Mode keys set to **vi** (`mode-keys vi`).

| Key | Action |
|-----|--------|
| `[` | Enter copy mode |
| `q` | Exit copy mode |
| `/` | Search forward |
| `?` | Search backward |
| `n` / `N` | Next / previous match |
| `v` | Begin selection (if configured) |
| `y` | Yank selection (if configured) |
| `Space` | Begin selection (default) |
| `Enter` | Copy selection & exit |
| `h/j/k/l` | Navigate (vi movement) |
| `Ctrl-u/d` | Page up / down |
| `g` / `G` | Top / bottom of buffer |

> Scrollback history: **10,000 lines**.

---

## Mouse

Mouse mode is **enabled**. You can:
- Click to select pane
- Drag to resize panes
- Scroll to enter copy mode
- Click to select window in status bar

---

## Custom Bindings

| Key | Action |
|-----|--------|
| **`r`** | Reload tmux config (`~/.tmux.conf`) |
| `Ctrl-h` / `Ctrl-l` | Cycle windows left / right |
| `h/j/k/l` | Vim-style pane navigation |

---

## Plugins (via TPM)

### TPM (Tmux Plugin Manager)

[Docs](https://github.com/tmux-plugins/tpm#readme)

Installed at `~/.tmux/plugins/tpm/`. Plugins are declared in `~/.tmux.conf` with `set -g @plugin 'author/plugin'`.

| Key | Action |
|-----|--------|
| `Prefix + I` | Install new plugins |
| `Prefix + U` | Update plugins |
| `Prefix + Alt-u` | Uninstall plugins removed from config |

To add a new plugin:
1. Add `set -g @plugin 'author/plugin'` to `.tmux.conf` (before the TPM `run` line)
2. Press `Prefix + I` to install
3. Press `Prefix + r` to reload config

### Dracula Theme

[Docs](https://draculatheme.com/tmux) | [Config options](https://github.com/dracula/tmux#configuration)

Status bar theme with powerline symbols. Current config:
- Shows **session name** on left (`show-left-icon session`)
- Shows **SSH session** info (`plugins "ssh-session"`)
- **Flags** enabled (marks current/last window)
- Status bar at **top** (`status-position top`)
- Empty plugins hidden

Available status bar plugins (add to `@dracula-plugins`):
`battery`, `cpu-usage`, `gpu-usage`, `ram-usage`, `tmux-ram-usage`, `network`, `network-bandwidth`, `network-ping`, `ssh-session`, `attached-clients`, `network-vpn`, `weather`, `time`, `spotify-tui`, `kubernetes-context`, `synchronize-panes`

| Config Option | Description |
|---------------|-------------|
| `@dracula-show-powerline true` | Enable powerline symbols |
| `@dracula-plugins "..."` | Space-separated list of status plugins |
| `@dracula-show-left-icon session` | Left icon: `session`, `smiley`, `window`, or custom |
| `@dracula-show-flags true` | Show window flags |
| `@dracula-show-empty-plugins false` | Hide empty plugin sections |
| `@dracula-border-contrast true` | Higher contrast pane borders |
| `@dracula-cpu-display-load true` | Show load average instead of % |

### tmux-fzf

[Docs](https://github.com/sainnhe/tmux-fzf#readme)

Fuzzy finder integration inside tmux.

| Key | Action |
|-----|--------|
| `Prefix + F` | Launch tmux-fzf |

Actions available through fzf menu:
- **session** -- switch, create, kill, rename, detach
- **window** -- switch, create, kill, rename, swap, link, move
- **pane** -- switch, kill, swap, break, join, layout
- **command** -- search and execute tmux commands
- **keybinding** -- search keybindings
- **clipboard** -- paste from buffer

| Environment Variable | Description |
|---------------------|-------------|
| `TMUX_FZF_LAUNCH_KEY` | Change launch key (default: `F`) |
| `TMUX_FZF_ORDER` | Reorder menu items |
| `TMUX_FZF_PREVIEW` | Enable/disable preview (0/1) |

### vim-tmux-navigator

[Docs](https://github.com/christoomey/vim-tmux-navigator#readme)

> Currently **commented out** in config but installed. Uncomment `set -g @plugin 'christoomey/vim-tmux-navigator'` to enable.

Seamless vim/tmux pane navigation (requires matching vim plugin):

| Key | Action |
|-----|--------|
| `Ctrl-h` | Move to left pane (or vim split) |
| `Ctrl-j` | Move to pane below (or vim split) |
| `Ctrl-k` | Move to pane above (or vim split) |
| `Ctrl-l` | Move to right pane (or vim split) |
| `Ctrl-\` | Move to previous pane |

---

## Command Mode

[tmux man page](https://man7.org/linux/man-pages/man1/tmux.1.html) | [tmux wiki](https://github.com/tmux/tmux/wiki) | [tmux cheat sheet (external)](https://tmuxcheatsheet.com/)

| Key | Action |
|-----|--------|
| `:` | Enter command mode |

### Session commands

```
:new-session -s name         # New session
:kill-session -t name        # Kill named session
:switch-client -t name       # Switch to session
:rename-session newname      # Rename current session
:detach-client               # Detach from session
```

### Window commands

```
:new-window -n name          # New named window
:kill-window                 # Kill current window
:swap-window -t 3            # Swap current window with 3
:move-window -t 5            # Move window to position 5
:link-window -s src -t dst   # Link window from another session
:rename-window newname       # Rename current window
```

### Pane commands

```
:split-window -h             # Horizontal split
:split-window -v             # Vertical split
:resize-pane -D 10           # Resize down 10
:resize-pane -R 20           # Resize right 20
:resize-pane -Z              # Toggle zoom
:swap-pane -D                # Swap with next pane
:swap-pane -U                # Swap with previous pane
:join-pane -t :1             # Move pane to window 1
:break-pane                  # Move pane to new window
:select-layout tiled         # Tile all panes evenly
:select-layout even-horizontal  # Even horizontal layout
:select-layout even-vertical    # Even vertical layout
```

### Sync & copy commands

```
:setw synchronize-panes on   # Type in all panes at once
:setw synchronize-panes off  # Disable sync
:capture-pane -S -1000       # Capture scrollback (1000 lines)
:save-buffer ~/out.txt       # Save buffer to file
:show-buffer                 # Show paste buffer contents
:list-buffers                # List all paste buffers
:choose-buffer               # Pick a paste buffer interactively
```

### Info & debug commands

```
:list-keys                   # Show all keybindings
:list-keys -T copy-mode-vi   # Show copy mode bindings
:display-message             # Show tmux info
:show-options -g             # Show global options
:show-options -w             # Show window options
:display-panes               # Show pane numbers
:clock-mode                  # Show clock
:info                        # Show server info
:source-file ~/.tmux.conf    # Reload config
```

---

## tmux-launch Layouts

Layout configs in `~/.config/tmux-layouts/*.toml`:

| Layout | Session | Description |
|--------|---------|-------------|
| `default` | (current) | Neovim + 3 shells |
| `claude` | (current) | Claude Code dev session |
| `stories` | stories | Analytic Stories + Claude |
| `detection` | detection | Detection Efficacy + Claude |
| `bastion` | bastion | All pod bastions (6 panes) |
| `servers` | servers | Home servers (5 panes) |
| `lab` | lab | Lab VMs: kali, ubuntu, rhel |
| `integrations` | integrations | TAS lab: pfsense, juniper, etc. |
| `monitor` | monitor | Monitor connections |

---

## Quick Reference Card

```
                        SESSIONS          WINDOWS           PANES
 ──────────────────────────────────────────────────────────────────
  Create               tmux new -s x     c                 " (horiz)
                                                            % (vert)
  Navigate             s (pick)          Ctrl-h / Ctrl-l   h j k l
  Rename               $                 ,                  --
  Kill                 tmux kill-ses     &                  x
  Zoom                 --                --                 z
 ──────────────────────────────────────────────────────────────────
  Reload config:  r          Copy mode:  [          Paste:  ]
  Detach:         d          Sync panes: :setw synchronize-panes on
  Fuzzy find:     F (fzf)    Plugins:    I (install) U (update)
```
