require('nordic').setup({
  -- This callback can be used to override the colors used in the base palette.
  on_palette = function(palette) end,
  -- This callback can be used to override the colors used in the extended palette.
  after_palette = function(palette) end,
  -- This callback can be used to override highlights before they are applied.
  on_highlight = function(highlights, palette)
    -- Fix visual mode text color
    highlights.Visual = { bg = '#3B4252', fg = '#D8DEE9' }
    highlights.VisualNOS = { bg = '#3B4252', fg = '#D8DEE9' }

    -- Fix cursorline blending
    highlights.CursorLine = { bg = palette.nord1, blend = 15 }
    highlights.CursorLineNr = { bg = palette.nord1, fg = palette.nord8, bold = true }

    -- Fix fold colors to blend with background
    highlights.Folded = { bg = palette.nord0, fg = palette.nord3 }
    highlights.FoldColumn = { bg = palette.nord0, fg = palette.nord3 }

    -- Fix LSP popup and completion menus
    highlights.Pmenu = { bg = '#3B4252', fg = '#D8DEE9' }
    highlights.PmenuSel = { bg = '#EBCB8B', fg = '#2E3440', bold = true }
    highlights.PmenuSbar = { bg = '#434C5E' }
    highlights.PmenuThumb = { bg = '#4C566A' }
    highlights.CmpItemAbbr = { fg = '#D8DEE9' }
    highlights.CmpItemAbbrDeprecated = { fg = '#4C566A', strikethrough = true }
    highlights.CmpItemAbbrMatch = { fg = '#88C0D0', bold = true }
    highlights.CmpItemAbbrMatchFuzzy = { fg = '#88C0D0', bold = true }
    highlights.CmpItemKind = { fg = '#8FBCBB' }
    highlights.CmpItemMenu = { fg = '#D08770' }
    highlights.CmpItemSel = { bg = '#EBCB8B', fg = '#2E3440', bold = true }
    highlights.CmpCursorLine = { bg = '#EBCB8B', fg = '#2E3440', bold = true }
    highlights.CmpItemSel = { bg = '#88C0D0', fg = '#2E3440', bold = true }
    highlights.CmpSel = { bg = '#88C0D0', fg = '#2E3440', bold = true }

    -- Fix mini.files colors
    highlights.MiniFilesBorder = { fg = palette.nord3, bg = palette.nord1 }
    highlights.MiniFilesBorderModified = { fg = palette.nord11, bg = palette.nord1 }
    highlights.MiniFilesCursorLine = { bg = palette.nord2, fg = palette.nord6 }
    highlights.MiniFilesDirectory = { fg = palette.nord8, bold = true }
    highlights.MiniFilesFile = { fg = palette.nord6 }
    highlights.MiniFilesNormal = { bg = palette.nord1, fg = palette.nord6 }
    highlights.MiniFilesTitle = { bg = palette.nord3, fg = palette.nord6, bold = true }

    -- Fix floating windows
    highlights.NormalFloat = { bg = palette.nord1, fg = palette.nord6 }
    highlights.FloatBorder = { fg = palette.nord3, bg = palette.nord1 }
  end,
  -- Enable bold keywords.
  bold_keywords = false,
  -- Enable italic comments.
  italic_comments = true,
  -- Enable editor background transparency.
  transparent = {
    -- Enable transparent background.
    bg = false,
    -- Enable transparent background for floating windows.
    float = false,
  },
  -- Enable brighter float border.
  bright_border = false,
  -- Reduce the overall amount of blue in the theme (diverges from base Nord).
  reduced_blue = true,
  -- Swap the dark background with the normal one.
  swap_backgrounds = false,
  -- Cursorline options.  Also includes visual/selection.
  cursorline = {
    -- Bold font in cursorline.
    bold = false,
    -- Bold cursorline number.
    bold_number = true,
    -- Available styles: 'dark', 'light'.
    theme = 'dark',
    -- Blending the cursorline bg with the buffer bg.
    blend = 0.15,
  },
  noice = {
    -- Available styles: `classic`, `flat`.
    style = 'classic',

  },
  telescope = {
    -- Available styles: `classic`, `flat`.
    style = 'flat',
  },
  leap = {
    -- Dims the backdrop when using leap.
    dim_backdrop = false,
  },
  ts_context = {
    -- Enables dark background for treesitter-context window
    dark_background = true,
  }
})

vim.cmd.colorscheme('nordic')
-- -- or
-- require('nordic').load()
