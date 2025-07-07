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

return {
  {
    "AstroNvim/astrotheme",
    priority = 1000,
    config = function()
      require("astrotheme").setup({ style = "dark" })
      vim.cmd("colorscheme astrodark")
    end,
  },
}

-- return {
--   {
--     "gbprod/nord.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("nord").setup({
--         -- transparent = true,
--       })
--       -- Lua
--       -- require("lualine").setup({
--       --   options = {
--       --     -- ... your lualine config
--       --     theme = "nord",
--       --     -- ... your lualine config
--       --   },
--       -- })
--       vim.cmd.colorscheme("nord")
--     end,
--   },
-- }
