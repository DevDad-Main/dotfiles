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
-- lua/plugins/colorscheme.lua
return {
  {
    "AstroNvim/astrotheme",
    priority = 1000,
    config = function()
      require("astrotheme").setup({
        style = {
          dark = "astrodark",
          float = true, -- enable floating window background
          border = true, -- enable floating window border
        },
        palettes = {
          astrodark = {
            ui = { accent = "#B3B3B3" }, -- lighter accent
          },
        },
        highlights = {
          astrodark = {
            FloatBorder = { fg = "#B3B3B3", bg = "none" }, -- pastel border
            NormalFloat = { bg = "#1a1b26" }, -- lighter float bg
          },
        },
      })
      vim.cmd("colorscheme astrodark")
    end,
  },
}
