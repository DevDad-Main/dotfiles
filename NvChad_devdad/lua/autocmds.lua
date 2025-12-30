require "nvchad.autocmds"

local api = vim.api

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- auto resize splits when the terminals window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- auto resize panes when resizing nvim window
vim.api.nvim_create_autocmd(
  "VimResized",
  { desc = "Auto resize panes when resizing nvim window", pattern = "*", command = "tabdo wincmd =" }
)

--no auto continue comments on new line
vim.api.nvim_create_autocmd("fileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove { "c", "r", "o" }
  end,
})

-- -- 2. Enable treesitter for highlighting
-- --    (core API, not handled by the plugin itself)
-- vim.api.nvim_create_autocmd("fileType", {
--   pattern = "*",
--   callback = function()
--     vim.treesitter.start()   -- start treesitter on every filetype
--   end,
-- })

-- Don't want relative no on inactive Windows
-- local relativeNo = api.nvim_create_augroup("RelativeNo", { clear = true })
--
-- api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
--   pattern = "*",
--   group = relativeNo,
--   callback = function()
--     if not vim.g.zen_mode_active then
--       vim.cmd([[set relativenumber]])
--     end
--   end,
-- })
--
-- api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
--   pattern = "*",
--   group = relativeNo,
--   callback = function()
--     if not vim.g.zen_mode_active then
--       vim.cmd([[set norelativenumber]])
--     end
--   end,
-- })


-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = yankGrp,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yank",
})

-- #region CursorLine AutoCommands to show the vertical Line
---- show cursor line only in active window
-- local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
-- api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
-- api.nvim_create_autocmd(
--   { "InsertEnter", "WinLeave" },
--   { pattern = "*", command = "set nocursorline", group = cursorGrp }
-- )
--
-- -- show cursor col line only in active window
-- local cursorColGrp = api.nvim_create_augroup("CursorColumn", { clear = true })
-- api.nvim_create_autocmd(
--   { "InsertLeave", "WinEnter" },
--   { pattern = "*", command = "set cursorcolumn", group = cursorColGrp }
-- )
-- api.nvim_create_autocmd(
--   { "InsertEnter", "WinLeave" },
--   { pattern = "*", command = "set nocursorcolumn", group = cursorColGrp }
-- )
-- #endregion

-- show Blank Line only in active window
-- local blanklineGrp = api.nvim_create_augroup("BlankLine", { clear = true })
-- api.nvim_create_autocmd(
--   { "InsertLeave", "WinEnter" },
--   { pattern = "*", command = ":IndentBlanklineEnable", group = blanklineGrp }
-- )
-- api.nvim_create_autocmd(
--   { "InsertEnter", "WinLeave" },
--   { pattern = "*", command = ":IndentBlanklineDisable", group = blanklineGrp }
-- )
