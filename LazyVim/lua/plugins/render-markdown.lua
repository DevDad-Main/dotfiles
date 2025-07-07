-- return {}

-- -- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/render-markdown.lua
-- -- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/render-markdown.lua
--
-- -- https://github.com/MeanderingProgrammer/markdown.nvim
-- --
-- -- When I hover over markdown headings, this plugins goes away, so I need to
-- -- edit the default highlights
-- -- I tried adding this as an autocommand, in the options.lua
-- -- file, also in the markdownl.lua file, but the highlights kept being overriden
-- -- so the only way I was able to make it work was loading it
-- -- after the config.lazy in the init.lua file lamw25wmal
--
-- -- Require the colors.lua module and access the colors directly without
-- -- additional file reads
-- local colors = require("config.colors")
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
