-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load options from config
require("config.options")

-- Setup lazy.nvim
require("lazy").setup("plugins", {
  defaults = {
    lazy = false,
  },
  install = {
    colorscheme = { "vague" },
  },
  checker = {
    enabled = true,
  },
  change_detection = {
    notify = false,
  },
})

-- Load configurations
require("config.keymaps")
require("config.autocmds")
require("config.diagnostics")