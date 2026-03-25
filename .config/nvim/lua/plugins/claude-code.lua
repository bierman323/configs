return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("claude-code").setup({
      window = {
        position = "vertical",
        split_ratio = 0.4,
      },
    })
    vim.keymap.set("n", "<leader>cc", ":ClaudeCode<CR>", { noremap = true, silent = true, desc = "Toggle Claude Code" })
    vim.keymap.set("n", "<leader>cs", ":ClaudeCodeSend<CR>", { noremap = true, silent = true, desc = "Send to Claude" })
    vim.keymap.set("v", "<leader>cs", ":ClaudeCodeSend<CR>", { noremap = true, silent = true, desc = "Send selection to Claude" })
  end,
}
