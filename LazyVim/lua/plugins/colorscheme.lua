--#region Arctic -> VS CODE
-- return {
--   {
--     "rockyzhang24/arctic.nvim",
--     dependencies = { "rktjmp/lush.nvim" },
--     name = "arctic",
--     branch = "main",
--     priority = 1000,
--     config = function()
--       vim.cmd("colorscheme arctic")
--     end,
--   },
-- }
--#endregion

--#region
-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = false, -- load during startup
--     priority = 1000, -- load before other plugins
--     config = function()
--       require("catppuccin").setup({
--         flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
--         transparent_background = false,
--         integrations = {
--           cmp = true,
--           gitsigns = true,
--           nvimtree = true,
--           telescope = true,
--           treesitter = true,
--           native_lsp = {
--             enabled = true,
--             virtual_text = {
--               errors = { "italic" },
--               hints = { "italic" },
--               warnings = { "italic" },
--               information = { "italic" },
--             },
--             underlines = {
--               errors = { "underline" },
--               hints = { "underline" },
--               warnings = { "underline" },
--               information = { "underline" },
--             },
--           },
--         },
--       })
--
--       -- Set colorscheme
--       vim.cmd.colorscheme("catppuccin")
--     end,
--   },
-- }
--#endregion

-- return {
--   {
--     "EdenEast/nightfox.nvim",
--     priority = 1000,
--     config = function()
--       require("nightfox").setup({
--         transparent = true,
--         float = true,
--       })
--       vim.cmd("colorscheme nordfox")
--     end,
--   },
-- }

--#region GruvBox
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        background = "dark",
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
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
--#endregion

-- return {
--   {
--     "EdenEast/nightfox.nvim",
--     priority = 1000,
--     config = function()
--       require("nightfox").setup({
--         transparent = true,
--         float = true,
--         -- palettes = {
--         --   nordfox = {
--         --     -- Lighten the background shades
--         --     -- bg0 = "#2e3440", -- Original dark alternative
--         --     -- bg1 = "#3b4252", -- Lighten bg1 from the default #2e3440
--         --     -- bg2 = "#434c5e", -- Lighten bg2 for better blending
--         --     -- bg3 = "#4c566a", -- Lighten bg3
--         --     -- bg4 = "#d8dee9", -- Adjust bg4 if needed for contrast
--         --     -- Ensure sel0 and sel1 (selection colors) also blend well
--         --   },
--         -- },
--       })
--       vim.cmd("colorscheme nordfox")
--     end,
--   },
-- }
-- --#endregion
--
--#region Astro Nvim Theme
-- return {
--   {
--     "AstroNvim/astrotheme",
--     priority = 1000,
--     config = function()
--       require("astrotheme").setup({
--         style = {
--           dark = "astrodark",
--           float = true, -- enable floating window background
--           border = true, -- enable floating window border
--           transparent = true,
--           background = false,
--         },
--         palettes = {
--           astrodark = {
--             ui = { accent = "#B3B3B3" }, -- lighter accent
--           },
--         },
--         highlights = {
--           astrodark = {
--             FloatBorder = { fg = "#B3B3B3", bg = "none" }, -- pastel border
--             NormalFloat = { bg = "#1a1b26" }, -- lighter float bg
--           },
--         },
--       })
--       vim.cmd("colorscheme astrodark")
--     end,
--   },
-- }
--#endregion
