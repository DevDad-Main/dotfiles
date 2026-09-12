--#region KeyMaps
-- Telescope isn't on the runtimepath until plugins load (after this file),
-- so require it lazily at keypress time instead of at startup.
local map = vim.keymap.set

-- -- Disable Space bar since it will be used as the leader key
-- vim.keymap.set({ "n", "v" }, "<leader>", "<nop>", { desc = "Disable leader key default" })

-- Redo remap
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Swap between split buffers
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", {
  silent = true,
  desc = "Move to left split",
})
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", {
  silent = true,
  desc = "Move to above split",
})
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Move to right split" })
vim.keymap.set("n", "<leader>rr", ":wincmd r<CR>", { silent = true, desc = "Rotate split buffers" })
vim.keymap.set("n", "<leader>re", ":restart<CR>", { silent = true, desc = "Restart Neovim" })

local multicursor_ns = vim.api.nvim_create_namespace("nvim.multicursor")
vim.keymap.set("n", "<Esc>", function()
  vim.cmd.nohlsearch()
  vim.api.nvim_buf_clear_namespace(0, multicursor_ns, 0, -1)
end, { desc = "Clear search highligts & multicursors" })

-- Save and quit current file quicker
vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true, noremap = true, desc = "Save current file" })
vim.keymap.set({ "n", "t" }, "<leader>q", ":q<cr>", { silent = true, noremap = true, desc = "Quit current buffer" })

-- Navigate through buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })

-- Close currently active buffer
vim.keymap.set("n", "<C-c>", ":bwipeout<CR>", { silent = true, desc = "Close current buffer" })

-- -- Center buffer when navigating up and down
-- vim.keymap.set("n", "<S-k>", "<C-u>zz", { desc = "Scroll up and center" })
-- vim.keymap.set("n", "<S-j>", "<C-d>zz", { desc = "Scroll down and center" })

-- Center buffer when progressing through search results
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Paste without replacing paste with what you are highlighted over
vim.keymap.set("n", "<leader>p", '"_dP', { desc = "Paste without replacing register" })

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Split management
map("n", "<leader>wv", "<Cmd>:vsplit<CR>", { desc = "Opens a buffer in a horizontal split" })
map("n", "<leader>ws", "<Cmd>:split<CR>", { desc = "Opens a buffer in a vertical split" })

-- Move selection up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Copy file path / selection reference for pasting into AI chats
local function copy_ref(opts)
  -- "%" is the current buffer's file name; ":p" expands it to the absolute path
  local path = vim.fn.expand("%:p")
  -- ref is what ends up in the clipboard; start with just the path
  local ref = path

  if opts.visual then
    -- '< and '> are only set after leaving visual mode, so read the live selection:
    -- "v" is the line where visual mode was started (the anchor)
    local start_line = vim.fn.line("v")
    -- "." is the line the cursor is on now (the moving end of the selection)
    local end_line = vim.fn.line(".")
    -- if the selection was made upward, swap so start is always the smaller line
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    -- append the range, e.g. "lua/config/keymaps.lua:1:23"
    ref = path .. ":" .. start_line .. ":" .. end_line
  end

  -- ask for an optional free-text note on the command line (Enter to skip)
  local note = vim.fn.input("Prompt (optional): ")
  if note ~= "" then
    -- append the note after the ref, separated by a space
    ref = ref .. " " .. note
  end

  -- write ref into the "+" register, which is the system clipboard
  vim.fn.setreg("+", ref)
  -- show a confirmation message with what was copied
  vim.notify("Copied: " .. ref)
end

-- visual mode: copy the file path plus the selected line range
vim.keymap.set("v", "<leader>cp", function()
  copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })

-- Utility maps.
map({ "n", "v", "x" }, "<leader>m", "<Cmd>Format<CR>", { desc = "Format current buffer" })
map("i", "jj", "<ESC>", { desc = "Escape Insert Mode Quicker" })
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })
map({ "n" }, "<leader><leader>", ":edit #<CR>", { desc = "Alternate file" })

-- Select all
map("n", "<leader>a", "<Cmd>:norm ggVG<CR>", { desc = "Visually selects everything in the file" })

-- Resize splits using Alt + hjkl
map("n", "<M-h>", "<cmd>vertical resize -5<CR>")
map("n", "<M-l>", "<cmd>vertical resize +5<CR>")
map("n", "<M-j>", "<cmd>resize +2<CR>")
map("n", "<M-k>", "<cmd>resize -2<CR>")


-- Inlay hints
map("n", "<leader>h", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggles Inlay Hints" })

-- Telescope maps
local function tpicker(name)
  return function()
    require("telescope.builtin")[name]()
  end
end

map({ "n" }, "<leader>g", tpicker("live_grep"), { desc = "Telescope live grep" })
map({ "n" }, "<leader>b", tpicker("buffers"), { desc = "Telescope open buffers" })
map({ "n" }, "<leader>si", tpicker("grep_string"), { desc = "Telescope grep word" })
map({ "n" }, "<leader>so", tpicker("oldfiles"), { desc = "Telescope search oldfiles" })
map({ "n" }, "<leader>sh", tpicker("help_tags"), { desc = "Telescope help tags" })
map({ "n" }, "<leader>sm", tpicker("man_pages"), { desc = "Telescope man pages" })
map({ "n" }, "<leader>sr", tpicker("lsp_references"), { desc = "Telescope LSP references" })
map({ "n" }, "<leader>sd", tpicker("lsp_definitions"), { desc = "Telescope definitions" })
map({ "n" }, "<leader>sD", tpicker("diagnostics"), { desc = "Telescope diagnostics" })
map({ "n" }, "<leader>sT", tpicker("lsp_type_definitions"), { desc = "Telescope LSP type definitions" })
map({ "n" }, "<leader>ss", tpicker("current_buffer_fuzzy_find"), { desc = "Telescope search current buffer" })
map({ "n" }, "<leader>st", tpicker("builtin"), { desc = "Telescope builtin pickers" })
map({ "n" }, "<leader>sc", tpicker("spell_suggest"), { desc = "Telescope spelling suggestions" })
map({ "n" }, "<leader>sk", tpicker("keymaps"), { desc = "Telescope keymaps" })


-- Window Navigation
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Window Right" })
