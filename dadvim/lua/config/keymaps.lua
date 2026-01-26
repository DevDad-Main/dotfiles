-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>")

-- Change completion navigation from Ctrl+N/P to Ctrl+J/K
vim.keymap.set("i", "<C-j>", "<C-n>")
vim.keymap.set("i", "<C-k>", "<C-p>")

-- Togggle Lsp Inlay hints with custom Command -> usercmd.lua
vim.keymap.set("n", "<leader>h", "<cmd>ToggleInlayHints<cr>", { desc = "Toggle Inlay Hints" })
