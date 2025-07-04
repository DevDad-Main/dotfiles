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
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      -- vim.g.zenbones_darken_comments = 45
      vim.cmd.colorscheme("zenbones")
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
