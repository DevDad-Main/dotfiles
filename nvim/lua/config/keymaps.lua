-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--BufferLine -> Use Tabs to cycle through Buffers
keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

--Codeium toggle
keymap.set("n", "<C-t>", "<cmd> Codeium Toggle<CR>")

-- TMUX Navigation
keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")

-- Split window
keymap.set("n", "sv", ":split<Return>", opts)
keymap.set("n", "ss", ":vsplit<Return>", opts)

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Allows to move to the beginning of a line and end of a line
keymap.set("i", "<C-a>", "<Home>")
keymap.set("i", "<C-e>", "<End>")

--Delete a word infront
keymap.set("i", "<C-d>", "<C-o>dw")

-- Move Cursor Right one character
keymap.set("i", "<c-l>", "<Right>")
keymap.set("i", "<c-h>", "<Left>")
