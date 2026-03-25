return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- nvim-treesitter now uses vim.treesitter directly (no more configs module)
    -- ensure_installed is handled by :TSInstall / :TSUpdate
    -- Highlight and indent are enabled by default in nvim 0.11+
    vim.treesitter.language.register("terraform", "terraform-vars")
  end,
}
