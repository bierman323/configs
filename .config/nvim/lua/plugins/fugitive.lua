return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", ":Git<CR>", { noremap = true, silent = true, desc = "Git status" })
    vim.keymap.set("n", "<leader>gh", ":diffget //3<CR>", { noremap = true, silent = true, desc = "Diffget right" })
    vim.keymap.set("n", "<leader>gu", ":diffget //2<CR>", { noremap = true, silent = true, desc = "Diffget left" })
    vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { noremap = true, silent = true, desc = "Git blame" })
    vim.keymap.set("n", "<leader>gl", ":Git log --oneline<CR>", { noremap = true, silent = true, desc = "Git log" })
  end,
}
