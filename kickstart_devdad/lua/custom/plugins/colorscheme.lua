--#region GruvBox
return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        background = 'dark',
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = '', -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      }
      vim.cmd 'colorscheme gruvbox'
    end,
  },
}
--#endregion

-- return {
--   {
--     'AstroNvim/astrotheme',
--     priority = 1000,
--     config = function()
--       require('astrotheme').setup {
--         style = {
--           dark = 'astrodark',
--           float = true, -- enable floating window background
--           border = true, -- enable floating window border
--           transparent = false, -- Disable transparent background
--         },
--         palettes = {
--           astrodark = {
--             ui = { accent = '#B3B3B3' }, -- lighter accent
--           },
--         },
--         highlights = {
--           astrodark = {
--             FloatBorder = { fg = '#B3B3B3', bg = 'none' }, -- pastel border
--             NormalFloat = { bg = '#1a1b26' }, -- lighter float bg
--           },
--         },
--         termguicolors = true,
--       }
--       vim.cmd 'colorscheme astrodark'
--     end,
--   },
-- }
