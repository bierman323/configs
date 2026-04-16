# tmux-layouts

YAML configuration files for [tmux-launch](~/bin/tmux-launch), a config-driven tmux session launcher and pane manager.

## Quick Start

```bash
# Launch a session from a layout
tmux-launch lab

# List all available layouts
tmux-launch --list

# Add windows from a layout into an existing session (run from inside tmux)
tmux-launch --add-window bastion

# Add a single labeled pane to the current window (run from inside tmux)
tmux-launch --add-pane -t "logs" -c "tail -f /var/log/syslog" -d v -p 30
```

## Config Directory

Layouts are read from `~/.config/tmux-layouts/`. Each `.yaml` file defines one launchable layout.

## YAML Schema

```yaml
description: "Human-readable description"
session: my-session          # tmux session name (defaults to filename)
directory: "~/projects"      # default working directory for all panes

# Shell commands to run before session creation (e.g. VPN auth)
pre_commands:
  - "sft resolve <bastion-host>"

# iTerm2 tab title and color (macOS terminal)
tab:
  title: "my-session"
  color: [80, 180, 80]       # RGB values

focus_window: 1              # which window to select after launch

windows:
  - name: editor
    layout: tiled             # tmux layout: tiled, even-horizontal, even-vertical, main-horizontal, main-vertical
    directory: "~/code"       # override session-level directory
    focus_pane: 1             # which pane to select in this window

    panes:
      - title: nvim
        command: nvim
        directory: "~/code/project"  # override window-level directory
      - title: shell
        split: h              # h(orizontal) or v(ertical)
        percent: 30           # pane size as percentage
```

### Directory Inheritance

Directory resolves with specificity: **pane > window > session**. Set it once at the session level and override only where needed.

### Split Direction

- `h` or `horizontal` -- split side-by-side (vertical divider)
- `v` or `vertical` -- split top/bottom (horizontal divider)

## Available Layouts

| Layout | Session | Description |
|--------|---------|-------------|
| `default` | (filename) | Neovim editor + shell windows |
| `claude` | (filename) | Claude Code dev session with shell and claude panes |
| `lab` | lab | SSH to lab VMs (kali, ubuntu, rhel) in tiled layout |
| `servers` | servers | SSH to home servers (mini, trailer, big-boy, etc.) |
| `bastion` | bastion | SSH to bastion hosts across all pods (us/ca/eu/au) |
| `integrations` | integrations | TAS integrations lab with firewall/network devices |
| `monitor` | monitor | Remote monitoring connections |
| `detection` | detection | Detection efficacy IDE -- claude (70%) + shell (30%) in `~/code/detection-efficacy` |
| `stories` | stories | Analytic stories IDE -- claude (70%) + shell (30%) in `~/code/analytic-stories` |

## Usage Examples

### Launch a full session

```bash
# Start the lab session -- connects to all lab VMs in a tiled layout
tmux-launch lab

# If the session already exists, it reattaches instead of creating a duplicate
tmux-launch lab
```

### Add windows to a running session

From inside an existing tmux session, pull in windows from another layout without leaving your current session:

```bash
# You're working in your default dev session and need bastion access
tmux-launch --add-window bastion

# Add server connections alongside your current work
tmux-launch --add-window servers
```

This creates new windows in your current session using the window definitions from the specified layout.

### Add a quick pane

Split the current window and add a labeled pane on the fly:

```bash
# Add a horizontal pane running htop, taking 30% of the space
tmux-launch --add-pane -t "htop" -c "htop" -d h -p 30

# Add a vertical pane with a log tail
tmux-launch --add-pane -t "logs" -c "tail -f /var/log/app.log" -d v -p 25

# Add a plain shell pane (defaults: horizontal split, 50%, runs zsh)
tmux-launch --add-pane -t "scratch"
```

### Pre-commands for authenticated environments

Layouts like `bastion` and `integrations` use `pre_commands` to handle authentication before SSH connections:

```yaml
pre_commands:
  - "sft resolve <bastion-host>"
```

These run as shell commands before the tmux session is created.

### Tab customization (iTerm2)

The `claude` layout sets the terminal tab title and color for visual identification:

```yaml
tab:
  title: "claude-dev"
  color: [80, 180, 80]    # green tab
```

## Creating a New Layout

1. Create `~/.config/tmux-layouts/myname.yaml`
2. Define your windows and panes
3. Launch with `tmux-launch myname`

Minimal example:

```yaml
description: "My project workspace"
directory: "~/projects/myapp"
windows:
  - name: editor
    panes:
      - title: nvim
        command: nvim
  - name: servers
    panes:
      - title: api
        command: "npm run dev"
      - title: logs
        split: h
        percent: 40
        command: "tail -f logs/dev.log"
```
