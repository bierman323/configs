---
tags: [cheatsheet, vim, neovim, tools]
aliases: [vim keys, neovim reference, nvim cheatsheet]
---

# Vim / Neovim Cheatsheet

> **Leader**: `\` (backslash)
> Config: `~/.config/nvim/` (lazy.nvim plugin manager)
> Theme: Catppuccin | Statusline: Lualine (Dracula)

---

## Modes

| Key | Mode | Description |
|-----|------|-------------|
| `i` | Insert | Insert before cursor |
| `I` | Insert | Insert at beginning of line |
| `a` | Insert | Append after cursor |
| `A` | Insert | Append at end of line |
| `o` | Insert | Open new line below |
| `O` | Insert | Open new line above |
| `v` | Visual | Character-wise selection |
| `V` | Visual | Line-wise selection |
| `Ctrl-v` | Visual Block | Column selection |
| `R` | Replace | Overtype mode |
| `:` | Command | Enter command line |
| `Esc` | Normal | Return to normal mode |

---

## Motion

### Basic Movement

| Key | Action |
|-----|--------|
| `h` / `l` | Left / right |
| `j` / `k` | Down / up |
| `w` / `W` | Next word / WORD start |
| `e` / `E` | Next word / WORD end |
| `b` / `B` | Previous word / WORD start |
| `0` | Beginning of line |
| `^` | First non-blank character |
| `$` | End of line |
| `gg` | First line of file |
| `G` | Last line of file |
| `{number}G` | Go to line number |
| `{` / `}` | Previous / next paragraph |
| `(` / `)` | Previous / next sentence |
| `%` | Matching bracket |
| `H` / `M` / `L` | Top / middle / bottom of screen |

### Scrolling

| Key | Action |
|-----|--------|
| `Ctrl-d` / `Ctrl-u` | Half page down / up |
| `Ctrl-f` / `Ctrl-b` | Full page down / up |
| `Ctrl-e` / `Ctrl-y` | Scroll one line down / up |
| `zz` | Center cursor on screen |
| `zt` / `zb` | Cursor to top / bottom |

### Jumping

| Key | Action |
|-----|--------|
| `Ctrl-o` | Jump back (older position) |
| `Ctrl-i` | Jump forward (newer position) |
| `` ` `` `` ` `` | Jump to last position |
| `gi` | Jump to last insert position and enter insert mode |
| `gd` | Go to definition (LSP) |

---

## Editing

### Operators (combine with motions)

| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete + insert) |
| `y` | Yank (copy) |
| `>` / `<` | Indent / dedent |
| `=` | Auto-indent |
| `gU` / `gu` | Uppercase / lowercase |

### Common Combinations

| Key | Action |
|-----|--------|
| `dd` | Delete line |
| `cc` | Change entire line |
| `yy` | Yank line |
| `D` | Delete to end of line |
| `C` | Change to end of line |
| `x` | Delete character under cursor |
| `s` | Substitute character (delete + insert) |
| `S` | Substitute entire line |
| `r{char}` | Replace single character |
| `J` | Join line below to current |
| `~` | Toggle case of character |
| `.` | Repeat last change |
| `u` | Undo |
| `Ctrl-r` | Redo |

### Text Objects (use with operators)

| Key | Scope | Examples |
|-----|-------|---------|
| `iw` / `aw` | Word | `diw` delete inner word, `caw` change a word |
| `is` / `as` | Sentence | `dis` delete inner sentence |
| `ip` / `ap` | Paragraph | `yip` yank inner paragraph |
| `i"` / `a"` | Double quotes | `ci"` change inside quotes |
| `i'` / `a'` | Single quotes | `di'` delete inside quotes |
| `i)` / `a)` | Parentheses | `ci)` change inside parens |
| `i]` / `a]` | Brackets | `di]` delete inside brackets |
| `i}` / `a}` | Braces | `ci}` change inside braces |
| `it` / `at` | HTML tag | `dit` delete inside tag |

---

## Search & Replace

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search word under cursor forward / backward |
| **`\<space>`** | **Clear search highlighting** |
| **`\r`** | **Search and replace (cursor in replace field)** |
| **`\rc`** | **Search and replace with confirm** |
| **`s*`** | **Multi-cursor workaround: type replacement, then `.` to repeat** |
| **`s*`** (visual) | **Same as above but for visual selection** |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirm |
| `:s/old/new/g` | Replace all on current line |

---

## Registers & Clipboard

| Key | Action |
|-----|--------|
| `"ay` | Yank into register `a` |
| `"ap` | Paste from register `a` |
| `"+y` | Yank to system clipboard |
| `"+p` | Paste from system clipboard |
| **`\sc`** | **System clipboard register (`"*`)** |
| `:reg` | Show all registers |
| `p` / `P` | Paste after / before cursor |

---

## Windows & Splits

| Key | Action |
|-----|--------|
| `:vs` / `Ctrl-w v` | Vertical split |
| `:sp` / `Ctrl-w s` | Horizontal split |
| `Ctrl-w h/j/k/l` | Navigate splits (vim movement) |
| `Ctrl-w H/J/K/L` | Move split to far left/bottom/top/right |
| `Ctrl-w =` | Equalize split sizes |
| `Ctrl-w +/-` | Increase / decrease height |
| `Ctrl-w >/<` | Increase / decrease width |
| `Ctrl-w q` | Close split |
| `Ctrl-w o` | Close all other splits |
| `Ctrl-w r` | Rotate splits |
| `Ctrl-w T` | Move split to new tab |

> Splits open to the **right** (`splitright`) and **below** (`splitbelow`).

---

## Buffers & Tabs

| Key | Action |
|-----|--------|
| `:e file` | Edit file in new buffer |
| `:bn` / `:bp` | Next / previous buffer |
| `:bd` | Delete (close) buffer |
| `:ls` | List buffers |
| `:b{n}` | Switch to buffer number |
| `:tabnew` | New tab |
| `gt` / `gT` | Next / previous tab |

> Lualine tabline shows **windows** on left, **buffers** on right.

---

## Marks

| Key | Action |
|-----|--------|
| `m{a-z}` | Set local mark |
| `m{A-Z}` | Set global mark (across files) |
| `` `{mark} `` | Jump to mark (exact position) |
| `'{mark}` | Jump to mark (line start) |
| `:marks` | List all marks |
| `` `0 `` | Position when last exited vim |

---

## Macros

| Key | Action |
|-----|--------|
| `q{a-z}` | Start recording macro to register |
| `q` | Stop recording |
| `@{a-z}` | Play macro |
| `@@` | Repeat last macro |
| `{n}@{a-z}` | Play macro n times |

---

## Folding

| Key | Action |
|-----|--------|
| `za` | Toggle fold |
| `zo` / `zc` | Open / close fold |
| `zR` / `zM` | Open all / close all folds |
| `zj` / `zk` | Next / previous fold |

---

## Custom Bindings

### General

| Key | Action |
|-----|--------|
| **`\ev`** | Edit vim-options.lua in vertical split |
| **`\vs`** | Open blank vertical split |
| **`\t`** | Open terminal below |
| **`\<space>`** | Clear search highlighting |
| **`\jf`** | Format JSON with python json.tool |
| **`\jq`** | Format JSON with jq (sorted keys) |
| **`\sc`** | System clipboard register (`"*`) |
| **`Ctrl-u`** (insert) | Uppercase previous word |
| **`\r`** | Search and replace |
| **`\rc`** | Search and replace with confirm |
| **`s*`** | Multi-cursor: type replacement, `.` to repeat |
| **`\b`** (visual) | Base64 decode selection into new tab |

### LSP

| Key | Action |
|-----|--------|
| **`K`** | Hover documentation |
| **`gd`** | Go to definition |
| **`gr`** | References |
| **`gi`** | Go to implementation |
| **`\ca`** | Code actions |
| **`\rn`** | Rename symbol |
| **`\gf`** | Format file (none-ls / LSP) |
| **`\d`** | Diagnostic float |
| **`[d`** / **`]d`** | Previous / next diagnostic |

### Git (vim-fugitive)

| Key | Action |
|-----|--------|
| **`\gs`** | Git status |
| **`\gh`** | Diffget right (//3) |
| **`\gu`** | Diffget left (//2) |
| **`\gb`** | Git blame |
| **`\gl`** | Git log (oneline) |

### Claude Code

| Key | Action |
|-----|--------|
| **`\cc`** | Toggle Claude Code pane |
| **`\cs`** | Send to Claude (normal or visual) |

---

## Plugins (via lazy.nvim)

### Lazy.nvim (Plugin Manager)

[Docs](https://lazy.folke.io/)

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager UI |
| `:Lazy sync` | Install, clean, update all plugins |
| `:Lazy update` | Update all plugins |
| `:Lazy check` | Check for plugin updates |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy health` | Run health checks |
| `:Lazy profile` | Show plugin load times |

### Telescope (Fuzzy Finder)

[Docs](https://github.com/nvim-telescope/telescope.nvim#usage)

Custom keymaps:

| Key | Action |
|-----|--------|
| **`Ctrl-p`** | Find files |
| **`\fg`** | Live grep (search content) |

Other built-in pickers (run with `:Telescope <picker>`):

| Command | Action |
|---------|--------|
| `:Telescope buffers` | List open buffers |
| `:Telescope oldfiles` | Recently opened files |
| `:Telescope help_tags` | Search help docs |
| `:Telescope keymaps` | Search all keymaps |
| `:Telescope commands` | Search all commands |
| `:Telescope diagnostics` | LSP diagnostics |
| `:Telescope lsp_references` | LSP references for word under cursor |
| `:Telescope git_commits` | Browse git commits |
| `:Telescope git_status` | Git changed files |

Inside Telescope picker:

| Key | Action |
|-----|--------|
| `Ctrl-n` / `Ctrl-p` | Next / previous result |
| `Enter` | Open file |
| `Ctrl-x` | Open in horizontal split |
| `Ctrl-v` | Open in vertical split |
| `Ctrl-t` | Open in new tab |
| `Esc` | Close picker |

### Neo-tree (File Explorer)

[Docs](https://github.com/nvim-neo-tree/neo-tree.nvim#quickstart)

| Key | Action |
|-----|--------|
| **`Ctrl-e`** | Toggle Neo-tree sidebar |

| Command | Action |
|---------|--------|
| `:Neotree` | Open file tree (left sidebar) |
| `:Neotree close` | Close file tree |
| `:Neotree reveal` | Open tree and reveal current file |
| `:Neotree buffers` | Show open buffers in tree |
| `:Neotree git_status` | Show git changed files in tree |
| `:Neotree float` | Open tree as floating window |

Inside Neo-tree:

| Key | Action |
|-----|--------|
| `Enter` | Open file / toggle directory |
| `a` | Add file/directory |
| `d` | Delete |
| `r` | Rename |
| `c` / `m` | Copy / move |
| `y` | Copy path to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `q` | Close Neo-tree |
| `R` | Refresh |
| `H` | Toggle hidden files |
| `?` | Show help |

### LSP (Language Server Protocol)

[nvim-lspconfig docs](https://github.com/neovim/nvim-lspconfig#readme) | [nvim 0.11 LSP guide](https://neovim.io/doc/user/lsp.html)

Custom keymaps:

| Key | Action |
|-----|--------|
| **`K`** | Hover documentation |
| **`gd`** | Go to definition |
| **`gr`** | References |
| **`gi`** | Go to implementation |
| **`\ca`** | Code actions |
| **`\rn`** | Rename symbol |
| **`\gf`** | Format file |
| **`\d`** | Diagnostic float |
| **`[d`** / **`]d`** | Previous / next diagnostic |

Useful commands:

| Command | Action |
|---------|--------|
| `:LspInfo` | Show active LSP clients for current buffer |
| `:LspLog` | Open LSP log file |
| `:LspRestart` | Restart LSP clients |
| `:checkhealth lsp` | Run LSP health check |

Configured servers (11 via Mason, using nvim 0.11 `vim.lsp.config` API):
- `lua_ls` -- Lua
- `pyright` -- Python
- `bashls` -- Bash
- `ansiblels` -- Ansible
- `yamlls` -- YAML (with GitHub workflow schema)
- `jsonls` -- JSON
- `gopls` -- Go
- `terraformls` -- Terraform
- `ts_ls` -- TypeScript / JavaScript
- `dockerls` -- Dockerfile
- `docker_compose_language_service` -- Docker Compose

### Mason (LSP Server Installer)

[Docs](https://github.com/williamboman/mason.nvim#readme) | [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim#readme)

| Command | Action |
|---------|--------|
| `:Mason` | Open Mason UI (install/update/remove servers) |
| `:MasonInstall <server>` | Install a specific server |
| `:MasonUninstall <server>` | Remove a server |
| `:MasonUpdate` | Update all installed servers |
| `:MasonLog` | Open Mason log file |

In the Mason UI, press `i` to install, `u` to update, `X` to uninstall.

### Treesitter (Syntax Highlighting & Indentation)

[Docs](https://github.com/nvim-treesitter/nvim-treesitter#readme) | [Playground](https://tree-sitter.github.io/tree-sitter/playground)

| Command | Action |
|---------|--------|
| `:TSInstall <lang>` | Install a language parser |
| `:TSUpdate` | Update all installed parsers |
| `:TSUninstall <lang>` | Remove a parser |
| `:InspectTree` | Open syntax tree inspector (nvim 0.11 built-in) |
| `:Inspect` | Show highlight groups under cursor |
| `:TSModuleInfo` | Show which modules are enabled per language |

16 parsers installed: `lua`, `python`, `bash`, `yaml`, `json`, `go`, `terraform`, `hcl`, `dockerfile`, `toml`, `markdown`, `markdown_inline`, `javascript`, `typescript`

### none-ls / null-ls (Formatting & Diagnostics)

[Docs](https://github.com/nvimtools/none-ls.nvim#readme) | [Built-in sources](https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md)

| Key / Command | Action |
|---------------|--------|
| **`\gf`** | Format current file |
| `:NullLsInfo` | Show active sources for current buffer |
| `:NullLsLog` | Open null-ls log |

Currently configured: `stylua` (Lua formatting)

### vim-fugitive (Git)

[Docs](https://github.com/tpope/vim-fugitive#readme) | [Vimcast tutorials](http://vimcasts.org/episodes/archive/)

Custom keymaps:

| Key | Action |
|-----|--------|
| **`\gs`** | Git status (`:Git`) |
| **`\gh`** | Diffget right (//3) |
| **`\gu`** | Diffget left (//2) |
| **`\gb`** | Git blame |
| **`\gl`** | Git log (oneline) |

Commands:

| Command | Action |
|---------|--------|
| `:Git` | Open git status (stage with `-`, commit with `cc`) |
| `:Git diff` | Show diff |
| `:Git log` | Browse commit history |
| `:Git blame` | Inline blame annotations |
| `:Gdiffsplit` | Open diff in split view |
| `:Gread` | Revert file to index (`git checkout -- file`) |
| `:Gwrite` | Stage current file (`git add file`) |
| `:Git push` | Push to remote |
| `:Git pull` | Pull from remote |

In `:Git` status window:
- `s` -- stage file, `u` -- unstage file
- `-` -- toggle stage/unstage
- `=` -- toggle inline diff
- `cc` -- commit, `ca` -- amend
- `X` -- discard changes (checkout)

### claude-code.nvim (AI Assistant)

[Docs](https://github.com/greggh/claude-code.nvim#readme)

| Key / Command | Action |
|---------------|--------|
| **`\cc`** | Toggle Claude Code pane (vertical, 40% width) |
| **`\cs`** | Send to Claude (normal mode: whole file, visual: selection) |
| `:ClaudeCode` | Toggle Claude Code terminal |
| `:ClaudeCodeSend` | Send current buffer or selection to Claude |

### Catppuccin (Color Scheme)

[Docs](https://github.com/catppuccin/nvim#readme) | [Flavours](https://github.com/catppuccin/nvim#flavours)

| Command | Action |
|---------|--------|
| `:colorscheme catppuccin` | Switch to default flavor |
| `:colorscheme catppuccin-mocha` | Dark flavor |
| `:colorscheme catppuccin-latte` | Light flavor |
| `:colorscheme catppuccin-frappe` | Mid-dark flavor |
| `:colorscheme catppuccin-macchiato` | Mid-dark warm flavor |

### Lualine (Status Line)

[Docs](https://github.com/nvim-lualine/lualine.nvim#readme)

Current config: Dracula theme, tabline shows windows (left) and buffers (right). Configured in `~/.config/nvim/lua/plugins/lualine.lua`.

---

## Useful Commands

```
:w                     Save file
:q                     Quit
:wq / :x / ZZ          Save and quit
:q! / ZQ               Quit without saving
:wa                    Save all buffers
:qa                    Quit all buffers
:e!                    Revert to last saved
:set paste / nopaste   Toggle paste mode
:set wrap / nowrap     Toggle line wrap
:noh                   Clear search highlighting
:sort                  Sort selected lines
:sort u                Sort + remove duplicates
:!command              Run shell command
:r !command            Insert command output
:earlier 5m            Undo to 5 minutes ago
:later 5m              Redo to 5 minutes ago
:Mason                 Open Mason LSP installer
:TSUpdate              Update Treesitter parsers
:checkhealth           Run health checks
```

---

## Editor Settings

| Setting | Value |
|---------|-------|
| Tabs | 2 spaces (expandtab) |
| Indentation | Smart indent |
| Line numbers | Relative + absolute |
| Search | Incremental, smart case, highlight |
| Split direction | Right + below |
| Scroll offset | 8 lines |
| Sign column | Always visible |
| True color | Enabled (termguicolors) |
| Bells | Disabled (no error/visual bell) |
| Trailing whitespace | Auto-stripped on save |
| Leader | `\` (backslash) |
| Color scheme | Catppuccin |
| Statusline | Lualine (Dracula theme) |
| Tabline | Windows (left) + Buffers (right) |
| Neovim version | 0.11+ (uses `vim.lsp.config` API) |

---

## Quick Reference Card

```
  MOVEMENT          EDITING           SEARCH            OBJECTS
 ─────────────────────────────────────────────────────────────────
  h j k l           d  delete         /pattern          iw  word
  w b e             c  change         ?pattern          is  sentence
  0 ^ $             y  yank           n / N next        ip  paragraph
  gg / G            p  paste          * / # word        i"  quotes
  { } ( )           u  undo           \<space> clear    i)  parens
  % bracket         .  repeat         s* multi-cursor   i}  braces
 ─────────────────────────────────────────────────────────────────
  CUSTOM KEYS (leader = \)           PLUGINS
 ─────────────────────────────────────────────────────────────────
  \ev    edit config                  Ctrl-p   find files
  \vs    new split                    \fg      live grep
  \t     terminal                     Ctrl-e   neo-tree
  \jf    format JSON (python)         K        hover docs
  \jq    format JSON (jq)             gd       go to def
  \sc    clipboard register           gr       references
  \gf    format file                  \ca      code actions
  \r     search/replace               \rn      rename symbol
  \b     base64 decode (visual)       \d       diagnostics
 ─────────────────────────────────────────────────────────────────
  GIT (fugitive)                      CLAUDE CODE
 ─────────────────────────────────────────────────────────────────
  \gs    git status                   \cc      toggle pane
  \gb    git blame                    \cs      send to claude
  \gl    git log
  \gh    diffget //3
  \gu    diffget //2
```
