-- ~/.config/nvim/lua/plugins/live-server.lua
return {
  "barrett-ruth/live-server.nvim",
  -- build = "npm install -g live-server", -- Installs live-server globally if needed
  ft = { "html", "css", "javascript", "typescript", "markdown" }, -- Optional, only loads for these filetypes
  config = function()
    require("live-server").setup({
      -- Optional settings
      open_browser = true,
      port = 8080,
    })
  end,
  -- keys = {},
}
