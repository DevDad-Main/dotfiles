--#region Auto Commands
local api = vim.api

-- Set React files accordingly
api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.jsx", "*.tsx" },
  group = vim.api.nvim_create_augroup("TS", { clear = true }),
  callback = function()
    vim.cmd([[set filetype=typescriptreact]])
  end,
})

-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = yankGrp,
  pattern = "*",
  callback = function()
    vim.hl.on_yank()
  end,
  desc = "Highlight yank",
})

-- auto-reload files when modified externally
api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- auto resize splits when the terminals window is resized
api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- auto resize panes when resizing nvim window
api.nvim_create_autocmd("VimResized", {
  desc = "Auto resize panes when resizing nvim window",
  pattern = "*",
  command = "tabdo wincmd =",
})

--no auto continue comments on new line
api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Note: PackChanged autocmd removed as it was specific to vim.pack
--#endregion