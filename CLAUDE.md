# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository used across multiple environments:
- Personal Mac
- Work Mac (with GlobalProtect/Prisma Access - restricted environment)
- Linux servers (home and work labs)
- Docker containers
- Windows WSL2

The configuration automatically detects the environment and adapts accordingly.

**IMPORTANT - Security:** This repository is PUBLIC. Sensitive information (API keys, tokens, credentials) must NEVER be committed here. All sensitive data is stored in separate private repositories and loaded via `*_sensitive` files that are git-ignored.

## Key Architecture

### Environment Detection System

The `.zshrc` detects the environment early and sets flags that can be used throughout the configuration:

**Environment Variables:**
- `OS_VERSION` - Output of `uname` (Darwin, Linux, etc.)
- `IS_WORK_MAC` - Set to `true` if GlobalProtect is installed at `/Applications/GlobalProtect.app`
- `IS_DOCKER` - Set to `true` if `/.dockerenv` exists
- `IS_WSL` - Set to `true` if running on WSL2 (checks `/proc/version` for Microsoft/WSL)

**Work-Specific Configuration:**
When `IS_WORK_MAC=true`, the config sources `.zshrc_work` for work-specific settings like:
- Work proxy settings
- Work-specific PATH additions
- Restricted tool configurations
- Work aliases

**Usage Pattern:**
```zsh
# Conditionally configure based on environment
if [[ "$IS_WORK_MAC" == "true" ]]; then
  # Skip restricted tools
else
  # Load full configuration
fi

if [[ "$IS_DOCKER" == "true" ]]; then
  # Skip Docker-incompatible configs
fi

if [[ "$IS_WSL" == "true" ]]; then
  # WSL-specific adjustments
fi
```

### Security and Sensitive Information Handling

**CRITICAL:** This is a PUBLIC repository. NO sensitive information should ever be committed here.

**Pattern for Sensitive Data:**

All sensitive files are git-ignored via `.gitignore`:
- `.zshrc_sensitive` - General sensitive environment variables
- `.zshrc_work_sensitive` - Work-specific sensitive variables
- `.bash_sensitive` - Bash-specific sensitive variables
- Any file matching `*_sensitive` or `*.local`

**File Loading Order:**
1. `.zshrc_work` (public work config)
2. `.zshrc_sensitive` (private general secrets)
3. `.zshrc_work_sensitive` (private work secrets)

**What Goes in Sensitive Files:**
- API tokens (GitHub, OpenAI, AWS, etc.)
- Authentication credentials
- VPN passwords
- Proxy credentials
- Any personal information
- Company-specific secrets

**Storage Strategy:**
- Personal sensitive data: Store in private personal dotfiles repo
- Work sensitive data: Store in private work-accessible repo
- Both can be symlinked to this location: `~/.config/dotfiles/.zshrc_sensitive`

**Example `.zshrc_sensitive`:**
```zsh
export HOMEBREW_GITHUB_API_TOKEN="ghp_xxxxx"
export OPENAI_API_KEY="sk-xxxxx"
export AWS_ACCESS_KEY_ID="AKIA..."
```

**When Adding New Variables:**
1. Check if it contains sensitive data
2. If yes: Add to appropriate `*_sensitive` file (git-ignored)
3. If no: Add to public config files

### Shell Configuration Structure

The repository uses a modular ZSH configuration approach split across multiple files:

- **`.zshrc`** - Main entry point that orchestrates all other configurations
  - Detects OS version (`uname`) and stores in `$OS_VERSION`
  - Detects environment type (work Mac, Docker, WSL) and sets corresponding flags
  - Sources `.zshrc_work` if on work Mac with GlobalProtect
  - Sources `.zshrc_ohmyzsh` if Oh-My-Zsh is installed at `~/.local/oh-my-zsh`
  - Conditionally loads tool-specific configs based on command availability using `(( $+commands[tool] ))`
  - Sets up brew paths for macOS (`/opt/homebrew/bin/brew`) and Linux (`/home/linuxbrew/.linuxbrew/Homebrew/bin`)
  - Sources `.zshrc_eza` if eza is available
  - Configures PATH extensions at the end

- **`.zshrc_work`** - Work-specific configuration (sourced when `IS_WORK_MAC=true`)
  - Work proxy settings
  - Work-specific aliases and PATH additions
  - Configurations for restricted work environment

- **`.zshrc_ohmyzsh`** - Oh-My-Zsh specific configuration
  - Sets up Powerlevel10k theme if available, otherwise falls back to `bierman-fino` custom theme
  - Custom theme location: `bierman-fino.zsh-theme` in repository root
  - Uses minimal plugins (only `git`)

- **`.zshrc_eza`** - Modern `ls` replacement (eza) aliases with icons and git integration
  - `ll`, `lsd`, `lsf`, `lsfg`, `lsdg` - various listing formats with git status

### Tool Detection Pattern

The `.zshrc` uses a consistent pattern for conditional tool configuration:
```zsh
if (( $+commands[tool_name] )); then
  # configure tool
fi
```

This pattern is used for: eza, bat/batcat, fzf, nvim/vim, duf, ncdu, zoxide, thefuck

### Neovim Configuration

Uses **lazy.nvim** plugin manager with modular plugin architecture:

- **`init.lua`** - Bootstraps lazy.nvim and loads `vim-options` and `plugins`
- **`lua/vim-options.lua`** - Core editor settings (tabs=2 spaces, relative numbers, keybindings)
- **`lua/plugins/`** directory contains individual plugin configurations:
  - `lsp-config.lua` - Mason + LSP setup for lua_ls, ansiblels, pyrightls, bashls, dockerls
  - `telescope.lua` - Fuzzy finder (Ctrl-P for files, leader+fg for grep)
  - `neo-tree.lua`, `catppuccin.lua`, `lualine.lua`, `none-ls.lua`, `treesitter.lua`

Leader key is backslash (`\`)

### Tmux Configuration

- **Prefix remapped**: `Ctrl-Space` (instead of default Ctrl-B)
- **Vim-style pane navigation**: `Ctrl-Space` + `h/j/k/l` with repeat enabled
- **Window navigation**: `Ctrl-Space` + `Ctrl-h/l`
- **Plugins**: Uses TPM (Tmux Plugin Manager) with dracula theme, tmux-fzf
- **Config reload**: `Ctrl-Space` + `r`

### Legacy Vim Configuration

Uses **Vundle** for plugin management. Key plugins: vim-fugitive, vim-airline, gruvbox colorscheme, nerdtree.

## Important Patterns

### FZF Configuration

The `.zshrc` handles both old and new versions of fzf:
- New versions: Use `fzf --zsh` auto-configuration
- Old versions: Source manual key-bindings and completion from `/usr/share/doc/fzf/examples/`
- Custom config loaded from `.fzfrc` (walker-skip settings for directories to ignore)

### OS-Specific Handling

macOS-specific configurations are wrapped in:
```zsh
if [[ "$OS_VERSION" == "Darwin" ]]; then
  # macOS-specific configs
fi
```

Examples: `audiokill` alias, Tailscale path, VS Code CLI path

### Bat/Batcat Handling

The config handles the naming difference between package managers:
- Homebrew/most systems: `bat`
- Ubuntu/Debian: `batcat`

Both get aliased to `cat`

## File Symlinks Assumption

This is a dotfiles repository meant to be symlinked to the user's home directory. Files like `.zshrc`, `.tmux.conf`, `.vimrc` are expected to be symlinked from `~/.zshrc` → `~/.config/dotfiles/.zshrc`.

The neovim config should be symlinked: `~/.config/nvim` → `~/.config/dotfiles/.config/nvim`

## Common Keybindings

### Neovim
- `<leader>` = `\`
- `Ctrl-P` - Find files (Telescope)
- `\fg` - Live grep (Telescope)
- `K` - Hover documentation (LSP)
- `gd` - Go to definition (LSP)
- `\ca` - Code actions (LSP)
- `\ev` - Edit vim-options.lua in split
- `\jq` / `\jf` - Format JSON with jq or python json.tool

### Tmux
- `Ctrl-Space` - Prefix
- `Prefix` + `h/j/k/l` - Navigate panes (vim-style)
- `Prefix` + `Ctrl-h/l` - Switch windows
- `Prefix` + `r` - Reload config

### Vim (legacy)
- `Ctrl-E` - Toggle NERDTree
- `Alt-Arrow` - Navigate splits
- `\ev` - Edit vimrc in vertical split
- `\t` - Open terminal at bottom
- Similar JSON formatting shortcuts as neovim

## Environment Variables

**Environment Detection:**
- `OS_VERSION` - Set to `$(uname)`, used for OS detection (Darwin, Linux, etc.)
- `IS_WORK_MAC` - Boolean flag (`true`/`false`) indicating work Mac (GlobalProtect present)
- `IS_DOCKER` - Boolean flag (`true`/`false`) indicating Docker container environment
- `IS_WSL` - Boolean flag (`true`/`false`) indicating WSL2 environment

**Tool Configuration:**
- `EDITOR` - Set to `nvim` if available, else `vim`
- `FZF_DEFAULT_OPTS_FILE` - Points to `~/.fzfrc`
- `OH_MY_PATH` - Oh-My-Zsh installation path (`$HOME/.local/oh-my-zsh`)
- `ZSH` - Points to `$OH_MY_PATH` when Oh-My-Zsh is loaded

**History Settings:**
- `HISTSIZE=5000`
- `HISTFILE=~/.zsh_history`
- Options: `appendhistory`, `sharehistory`, `hist_ignore_space` enabled
