return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'dracula'
      },
      tabline = {
        lualine_a = {{
          'windows',
          mode = 2
        }},
        lualine_z = {{
          'buffers',
          mode = 4,
          use_mode_colors = true
        }}
      }
    })
  end
}
