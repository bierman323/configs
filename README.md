# configs

Personal dotfiles repository used across multiple environments: macOS (personal and work), Linux servers, Docker containers, and WSL2. The configuration automatically detects the environment and adapts accordingly.

## Structure

| Path | Description |
|------|-------------|
| `.zshrc` | Main ZSH config -- environment detection, tool setup, PATH |
| `.zshrc_work` | Work-specific settings (sourced when GlobalProtect is detected) |
| `.zshrc_ohmyzsh` | Oh-My-Zsh config with Powerlevel10k / bierman-fino theme |
| `.zshrc_eza` | Modern `ls` aliases using eza |
| `.zshrc_claude` | Claude Code shell integration |
| `.bashrc` / `.bash_profile` | Bash equivalents |
| `.tmux.conf` | Tmux config (Ctrl-Space prefix, vim-style navigation) |
| `.vimrc` | Legacy Vim config with Vundle |
| `.config/nvim/` | Neovim config with lazy.nvim |
| `.fzfrc` | FZF walker-skip settings |
| `.p10k.zsh` | Powerlevel10k prompt config |
| `tmux-layouts/` | YAML session configs for [tmux-launch](tmux-layouts/README.md) |
| `bierman-fino.zsh-theme` | Custom Oh-My-Zsh theme |
| `roles/` | Ansible roles for automated setup |
| `themes/` | Additional themes |

## tmux-layouts

The `tmux-layouts/` directory contains YAML configs that drive `tmux-launch`, a script for creating reproducible tmux sessions with named panes, SSH connections, and IDE-style layouts. See the [tmux-layouts README](tmux-layouts/README.md) for the full schema and usage examples.

## Setup

Files are symlinked from the home directory:

```bash
ln -s ~/.config/dotfiles/.zshrc ~/.zshrc
ln -s ~/.config/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.config/dotfiles/.config/nvim ~/.config/nvim
# etc.
```

## Security

This repository is **public**. Sensitive data (API keys, tokens, credentials) is stored in separate private repos and loaded via `*_sensitive` files that are git-ignored.