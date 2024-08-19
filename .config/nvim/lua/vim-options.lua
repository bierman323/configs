vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set nu")
vim.cmd("set relativenumber")
vim.cmd("set splitright")
vim.cmd("set splitbelow")
vim.cmd("set noerrorbells")
vim.cmd("set novisualbell")
vim.g.mapleader = "\\"
-- Copy to system clipboard
vim.keymap.set('n','<leader>sc','"*')
-- Open up the vim options file in a split
vim.keymap.set('n','<leader>ev',':vs ~/.config/nvim/lua/vim-options.lua<CR>', { noremap=true, silent=true })
-- Open up a blanck vertical split
vim.keymap.set('n','<leader>vs',':vs ene<CR>', { noremap=true, silent=true })
-- Open up a terminal. Useful when I'm in full screen
-- vim.keymap.set('n','<leader>te',':botright term<CR>', { noremap=true, silent=true })
-- Clear the search
vim.keymap.set('n','<leader><space>',':let @/=""<CR>', { noremap=true, silent=true })
-- Clean up json with jq
vim.keymap.set('n','<leader>jf',':%!python -m json.tool indent=2<CR>', { noremap=true, silent=true })
vim.keymap.set('n','<leader>jq',':%!jq -S .<CR>', { noremap=true, silent=true })
-- Uppercase the previous word
vim.keymap.set('i','<c-u>','<esc>gUiw', { noremap=true, silent=true })
