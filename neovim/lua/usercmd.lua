local create_cmd = vim.api.nvim_create_user_command
-- local settings = require("chadrc").settings
local g = vim.g
local fn = vim.fn


create_cmd("ToggleInlayHints", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
end, { desc = "Toggle inlay hints in current buffer" })
