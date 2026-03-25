return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "bashls",
          "ansiblels",
          "yamlls",
          "jsonls",
          "gopls",
          "terraformls",
          "ts_ls",
          "dockerls",
          "docker_compose_language_service",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- nvim 0.11+ uses vim.lsp.config() for server configs
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.lsp.config("pyright", {})
      vim.lsp.config("bashls", {})
      vim.lsp.config("ansiblels", {})

      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
          },
        },
      })

      vim.lsp.config("jsonls", {})
      vim.lsp.config("gopls", {})
      vim.lsp.config("terraformls", {})
      vim.lsp.config("ts_ls", {})
      vim.lsp.config("dockerls", {})
      vim.lsp.config("docker_compose_language_service", {})

      -- Enable all configured servers
      vim.lsp.enable({
        "lua_ls",
        "pyright",
        "bashls",
        "ansiblels",
        "yamlls",
        "jsonls",
        "gopls",
        "terraformls",
        "ts_ls",
        "dockerls",
        "docker_compose_language_service",
      })

      -- LSP keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic float" })
    end,
  },
}
