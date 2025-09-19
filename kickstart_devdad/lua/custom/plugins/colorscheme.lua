return {
  {
    'AstroNvim/astrotheme',
    priority = 1000,
    config = function()
      require('astrotheme').setup {
        style = {
          dark = 'astrodark',
          float = true, -- enable floating window background
          border = true, -- enable floating window border
          transparent = false, -- Disable transparent background
        },
        palettes = {
          astrodark = {
            ui = { accent = '#B3B3B3' }, -- lighter accent
          },
        },
        highlights = {
          astrodark = {
            FloatBorder = { fg = '#B3B3B3', bg = 'none' }, -- pastel border
            NormalFloat = { bg = '#1a1b26' }, -- lighter float bg
          },
        },
        termguicolors = true,
      }
      vim.cmd 'colorscheme astrodark'
    end,
  },
}
