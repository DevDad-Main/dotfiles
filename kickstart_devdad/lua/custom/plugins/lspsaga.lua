-- lua/plugins/lspsaga.lua
return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach', -- lazy load when LSP attaches
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- for symbols
    'nvim-tree/nvim-web-devicons', -- optional, for icons
  },
  config = function()
    require('lspsaga').setup {
      -- you can put global options here
      symbol_in_winbar = {
        enable = true,
        separator = ' › ',
        hide_keyword = false,
        show_file = true,
        folder_level = 1,
        color_mode = true,
        delay = 300,
      },
      lightbulb = {
        enable = false, -- 🚫 turn off the lightbulb
      },
      -- other lspsaga configs if desired
    }

    -- Optionally, set up autocommand so that winbar is updated per buffer
    -- Or, override winbar or statusline in LazyVim if needed
  end,
}
