-- Leader key
vim.g.mapleader = "\\"

-- Tabs & indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- UI
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.termguicolors = true

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- ── Keymaps ──

-- Copy to system clipboard
vim.keymap.set('n', '<leader>sc', '"*')

-- Open vim-options.lua in a split
vim.keymap.set('n', '<leader>ev', ':vs ~/.config/nvim/lua/vim-options.lua<CR>', { noremap = true, silent = true })

-- Open blank vertical split
vim.keymap.set('n', '<leader>vs', ':vs ene<CR>', { noremap = true, silent = true })

-- Open terminal below
vim.keymap.set('n', '<leader>t', ':botright split | terminal<CR>', { noremap = true, silent = true })

-- Clear search highlighting
vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>', { noremap = true, silent = true })

-- JSON formatting
vim.keymap.set('n', '<leader>jf', ':%!python3 -m json.tool --indent=2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>jq', ':%!jq -S .<CR>', { noremap = true, silent = true })

-- Uppercase previous word in insert mode
vim.keymap.set('i', '<c-u>', '<esc>gUiw`]a', { noremap = true, silent = true })

-- Search and replace (like vimrc \r and \rc)
vim.keymap.set('n', '<leader>r', ':%s///g<Left><Left>', { noremap = true })
vim.keymap.set('n', '<leader>rc', ':%s///gc<Left><Left><Left>', { noremap = true })

-- s* multi-cursor workaround: hit s* on word, type replacement, then . to repeat
vim.keymap.set('n', 's*', [[:let @/='\<'.expand('<cword>').'\>'<CR>cgn]], { noremap = true, silent = true })
vim.keymap.set('x', 's*', [["sy:let @/=@s<CR>cgn]], { noremap = true, silent = true })

-- Base64 decode visual selection into new tab
vim.keymap.set('v', '<leader>b', [[y:tabe|pu!=system('base64 -d', @@)<CR>]], { noremap = true, silent = true })
