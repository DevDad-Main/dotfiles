--#region KeyMaps
local function safe_require(module)
  local ok, mod = pcall(require, module)
  return ok and mod or nil
end

local builtin = safe_require("telescope.builtin")
local ls = safe_require("luasnip")
local actions_preview = safe_require("actions-preview")

local map = vim.keymap.set

-- System clipboard
map({ "n", "x" }, "<leader>y", '"+y')
map({ "v", "x", "n" }, "<C-y>", '"+y', { desc = "System clipboard yank." })

-- Snippet navigation
map({ "i", "s" }, "<C-e>", function()
  if ls then
    ls.expand_or_jump(1)
  end
end, { silent = true })
map({ "i", "s" }, "<C-J>", function()
  if ls then
    ls.jump(1)
  end
end, { silent = true })
map({ "i", "s" }, "<C-K>", function()
  if ls then
    ls.jump(-1)
  end
end, { silent = true })

-- Tab navigation
map({ "n" }, "<C-t>", "<Cmd>tabnew<CR>")
map({ "n" }, "<C-x>", "<Cmd>tabclose<CR>")
for i = 1, 8 do
  map({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

-- Config editing
map({ "n", "v", "x" }, "<leader>v", "<Cmd>edit $MYVIMRC<CR>", { desc = "Edit " .. vim.fn.expand("$MYVIMRC") })
map({ "n", "v", "x" }, "<leader>z", "<Cmd>e ~/.zshrc<CR>", { desc = "Edit .zshrc" })
map({ "n", "v", "x" }, "<leader>o", ":update<CR> :source<CR>", { desc = "Source config" })
map({ "n", "v", "x" }, "<leader>O", "<Cmd>restart<CR>", { desc = "Restart vim." })

-- Utility maps
map({ "n", "v", "x" }, "<leader>n", ":norm ", { desc = "Enter norm command." })
-- Only substites one instance, but i will change it for the below so i can add extra commands and and add gc to confirm or not
-- map({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Enter substitute mode in selection" })
map({ "n", "v", "x" }, "<C-s>", [[:%s/]], { desc = "Enter substitute mode in selection" })
map({ "n", "v", "x" }, "<leader>m", "<Cmd>Format<CR>", { desc = "Format current buffer" })

-- Telescope maps
if builtin then
  map({ "n" }, "<leader>g", builtin.live_grep)
  map({ "n" }, "<leader>t", "<CMD>:TodoTelescope<CR>")
  map({ "n" }, "<leader>b", builtin.buffers, { desc = "Telescope open buffers" })
  map({ "n" }, "<leader>si", builtin.grep_string, { desc = "Telescope grep word" })
  map({ "n" }, "<leader>so", builtin.oldfiles, { desc = "Telescope search old(recent) files" })
  map({ "n" }, "<leader>sh", builtin.help_tags, { desc = "Telescope open help tags" })
  map({ "n" }, "<leader>sm", builtin.man_pages, { desc = "Telescope open manual(:man)" })
  map({ "n" }, "<leader>sr", builtin.lsp_references, { desc = "Telescope show LSP references" })
  map({ "n" }, "<leader>sd", builtin.lsp_definitions, { desc = "Telescope definitions" })
  map({ "n" }, "<leader>sD", builtin.diagnostics, { desc = "Telescope Show Diagnostics" })
  map({ "n" }, "<leader>sT", builtin.lsp_type_definitions, { desc = "Telescope LSP Definitions" })
  map({ "n" }, "<leader>ss", builtin.current_buffer_fuzzy_find, { desc = "Telescope Fzf current Buffer" })
  map({ "n" }, "<leader>st", builtin.builtin, { desc = "Telescope Builtin Actions" })
  -- map({ "n" }, "<leader>sc", builtin.git_bcommits, { desc = "Telescope Git Commits" })
  map({ "n" }, "<leader>sc", builtin.spell_suggest, { desc = "Telescope Git Commits" })
  map({ "n" }, "<leader>sk", builtin.keymaps, { desc = "Telescope Keymaps" })
end

-- More maps
map("i", "jj", "<ESC>", { desc = "Escape Insert Mode Quicker" })
map("n", "<leader>d", "<Cmd>:bd<CR>", { desc = "Deletes the currently open buffer" })

function git_files()
  if builtin then
    builtin.find_files({ no_ignore = true })
  end
end

map({ "n" }, "<leader>sg", git_files)
map({ "n" }, "<leader>l", "<Cmd>LazyGit<CR>")
map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")

if actions_preview then
  map({ "n" }, "<leader>sa", actions_preview.code_actions)
end

-- Resize splits using Alt + hjkl
map("n", "<M-h>", "<cmd>vertical resize -5<CR>")
map("n", "<M-l>", "<cmd>vertical resize +5<CR>")
map("n", "<M-j>", "<cmd>resize +2<CR>")
map("n", "<M-k>", "<cmd>resize -2<CR>")

-- File management
map("n", "<leader>e", function()
  vim.cmd((vim.bo.filetype == "netrw") and "bd" or "Ex")
end, { desc = "Toggle Open Netrw" })

map("n", "<leader>-", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })

-- Misc maps
map({ "n" }, "<leader>c", "1z=")
map({ "n" }, "<C-q>", ":copen<CR>", { silent = true })
map({ "n" }, "<leader>w", "<Cmd>update<CR>", { desc = "Write the current buffer." })
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })
map({ "n" }, "<C-f>", "<Cmd>Open .<CR>", { desc = "Open current directory in Finder." })
map({ "n" }, "<leader>a", ":edit #<CR>", { desc = "Alternate file" })

-- Better navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Better default Ctrl-d but centers screen" })
map("n", "<C-u>", "<C-u>zz", { desc = "Better default Ctrl-u but centers screen" })
map("n", "n", "nzzzv", { desc = "Better 'n' for '/' search, centers screen and open folds" })
map("n", "N", "Nzzzv", { desc = "Better 'N' for '/' search, centers screen and open folds" })

-- Note: Tab completion is handled by blink.cmp automatically

-- Remove Search Highlighting, Dismiss Popups
map("n", "<esc>", function()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

-- Split management
map("n", "<leader>wv", "<Cmd>:vsplit<CR>", { desc = "Opens a buffer in a horizontal split" })
map("n", "<leader>ws", "<Cmd>:split<CR>", { desc = "Opens a buffer in a vertical split" })

-- Inlay hints
map("n", "<leader>h", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggles Inlay Hints" })

-- FFF
map("n", "<leader>f", function()
  require("fff").find_files()
end, { desc = "FFFind files" })

-- Select all
map("n", "<leader>a", "<Cmd>:norm ggVG<CR>", { desc = "Visually selects everything in the file" })

-- Legacy vim commands
vim.cmd([[
  nnoremap g= g+|
  nnoremap gK @='ddkPJ'<cr>|
  xnoremap gK <esc><cmd>keeppatterns '<,'>-global/$/normal! ddpkJ<cr>
  noremap! <c-r><c-d> <c-r>=strftime('%F')<cr>
  noremap! <c-r><c-t> <c-r>=strftime('%T')<cr>
  noremap! <c-r><c-f> <c-r>=expand('%:t')<cr>
  noremap! <c-r><c-p> <c-r>=expand('%:p')<cr>
  xnoremap <expr> . "<esc><cmd>'<,'>normal! ".v:count1.'.<cr>'
]])
--#endregion
