-- Map leader to comma. This lets me do a lot of shortcuts using both hands
vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- You will need to install language servers `npm i -g vscode-langservers-extracted` and `npm install -g typescript typescript-language-server`
require("lazy").setup({
  spec = "lazySetup",
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "single",
  },
})
require("options")
require("setup.spelling")
require("mappings")
require("usercmd")

-- ╭────────────────────────────────────────────────────────────────────────────╮
-- │ NOTE: Uncomment this if you want to use the midnight theme -> custom theme │
-- ╰────────────────────────────────────────────────────────────────────────────╯
--  Add themes directory to runtime path
--  vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/lua/setup/themes")
--
-- -- Load midnight theme
-- require("setup.themes.midnight").setup()
