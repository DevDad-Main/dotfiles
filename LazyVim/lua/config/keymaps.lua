-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--BufferLine -> Use Tabs to cycle through Buffers
-- keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
-- keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
-- Paste when in insert mode
keymap.set("i", "<C-v>", "<C-c>p")
-- Replaces the Ctrl c to go to normal mode as it is hard for me using touch typing, plus f i dont use, i will use s for leap anyways
-- keymap.set({ "i", "v" }, "f", "<C-c>")

-- -- Snipe Config -> Opens the snipe menu.
-- -- Navigate with j and k, d for deleting buffers and q to close menu
-- keymap.set("n", "<S-l>", function()
--   require("snipe").open_buffer_menu()
-- end, { desc = "Open Snipe buffer menu" })

-- Create a JsDoc comment when hovering over a function
keymap.set("n", "<leader><C-l>", "<Plug>(jsdoc)", { desc = "Create JsDoc Comment" })

-- Live Server Used mainly with Html projects etc
keymap.set("n", "<leader>ls", "<cmd>LiveServerStart<cr>", { desc = "Start Live Server" })
keymap.set("n", "<leader>lS", "<cmd>LiveServerStop<cr>", { desc = "Stop Live Server" })

-- Used mainly for markdown files as markdown-preview is outdated and has security issues
keymap.set("n", "<leader>lp", "<cmd>LivePreview start<cr>", { desc = "Start Live Preview" })

-- Stops Live Preview
keymap.set("n", "<leader>lP", "<cmd>LivePreview close<cr>", { desc = "Stop Live Preview" })

-- Example keybindings
keymap.set("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>')
keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

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
