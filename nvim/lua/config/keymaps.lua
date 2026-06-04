--#region KeyMaps
local function safe_require(module)
  local ok, mod = pcall(require, module)
  return ok and mod or nil
end

local builtin = safe_require("telescope.builtin")
local ls = safe_require("luasnip")
local actions_preview = safe_require("actions-preview")
local nvim_tmux_nav = require("nvim-tmux-navigation")

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
  map({ "n" }, "<leader>sc", builtin.spell_suggest, { desc = "Telescope Spelling Suggestions" })
  map({ "n" }, "<leader>sk", builtin.keymaps, { desc = "Telescope Keymaps" })
end

-- More maps
map("i", "jj", "<ESC>", { desc = "Escape Insert Mode Quicker" })
-- map("n", "<leader>d", "<Cmd>:bd<CR>", { desc = "Deletes the currently open buffer" })

map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" }) -- show  diagnostics for file

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" }) -- show diagnostics for line

function git_files()
  if builtin then
    builtin.find_files({ no_ignore = true })
  end
end

map({ "n" }, "<leader>sg", git_files)
-- map({ "n" }, "<leader>l", "<Cmd>LazyGit<CR>")
map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")
map({ "n" }, "<leader>pt", "<cmd>Telescope terms<cr>", { desc = "Pick terminal buffer" })

if actions_preview then
  map({ "n" }, "<leader>sa", actions_preview.code_actions)
end

-- Resize splits using Alt + hjkl
map("n", "<M-h>", "<cmd>vertical resize -5<CR>")
map("n", "<M-l>", "<cmd>vertical resize +5<CR>")
map("n", "<M-j>", "<cmd>resize +2<CR>")
map("n", "<M-k>", "<cmd>resize -2<CR>")

-- File management
-- map("n", "<leader>e", function()
--   vim.cmd((vim.bo.filetype == "netrw") and "bd" or "Ex")
-- end, { desc = "Toggle Open Netrw" })

map("n", "<leader>-", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })

-- Misc maps
map({ "n" }, "<leader>c", "1z=")
map({ "n" }, "<C-q>", ":copen<CR>", { silent = true })
map({ "n" }, "<leader>w", "<Cmd>update<CR>", { desc = "Write the current buffer." })
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })
-- map({ "n" }, "<C-f>", "<Cmd>Open .<CR>", { desc = "Open current directory in Finder." })
map({ "n" }, "<leader><leader>", ":edit #<CR>", { desc = "Alternate file" })

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

-- Pretty Ts Errors Toggle
-- map("n", "<leader>tt", function()
--   require("pretty-ts-errors").show_formatted_error()
-- end, { desc = "Toggles PrettyTS Floating window" })

-- Pretty Ts Show All
-- map("n", "<leader>te", function()
--   require("pretty-ts-errors").open_all_errors()
-- end, { desc = "Toggles PrettyTS Show All Errors" })

-- Toggle Supermaven
-- map("n", "<leader>ts", "<cmd>SupermavenToggle<cr>", { desc = "Toggles Supermaven" })

-- Initiate Pounce
map({ "n", "v" }, "h", ":Pounce<CR>", { silent = true, desc = "Pounce" })
-- Repeat Last Pounce
map("n", "H", ":PounceRepeat<CR>", { silent = true, desc = "Pounce Repeat" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Window Right" })

map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)

-- Quickly enter new line
map("i", "<C-;>", "<C-o>o", { noremap = true })

-- Safe require (so it doesn't error before InsertEnter)
local function blink_visible()
  local ok, blink = pcall(require, "blink.cmp")
  if not ok then
    return false
  end
  return blink.is_visible()
end

-- Left / Right (always fine)
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

-- Removes a character backwards, my backslash key is far away from my home row
map("i", "<C-x>", "<BS>", { noremap = true })

-- -- Down
-- vim.keymap.set("i", "<C-j>", function()
--   if blink_visible() then
--     return "<C-j>" -- let blink handle it
--   end
--   return "<C-o>j"
-- end, { expr = true })
--
-- -- Up
-- vim.keymap.set("i", "<C-k>", function()
--   if blink_visible() then
--     return "<C-k>" -- let blink handle it
--   end
--   return "<C-o>k"
-- end, { expr = true })

-- Treesitter textobjects
local ts_select = require("nvim-treesitter-textobjects.select")

local function select_ts_textobject(query, desc)
  local ok, parser = pcall(vim.treesitter.get_parser)
  if not ok or not parser then
    vim.notify("Treesitter parser not available", vim.log.levels.WARN)
    return
  end
  ts_select.select_textobject(query, "textobjects")
end

map({ "o", "x" }, "af", function()
  select_ts_textobject("@function.outer", "function")
end, { desc = "Select outer part of a function" })

map({ "o", "x" }, "if", function()
  select_ts_textobject("@function.inner", "function")
end, { desc = "Select inner part of a function" })

map({ "o", "x" }, "ac", function()
  select_ts_textobject("@class.outer", "class")
end, { desc = "Select outer part of a class" })

map({ "o", "x" }, "ic", function()
  select_ts_textobject("@class.inner", "class")
end, { desc = "Select inner part of a class" })

map({ "o", "x" }, "ab", function()
  select_ts_textobject("@block.outer", "block")
end, { desc = "Select outer part of a block" })

map({ "o", "x" }, "ib", function()
  select_ts_textobject("@block.inner", "block")
end, { desc = "Select inner part of a block" })

map({ "o", "x" }, "aa", function()
  select_ts_textobject("@parameter.outer", "parameter")
end, { desc = "Select outer part of a parameter" })

map({ "o", "x" }, "ia", function()
  select_ts_textobject("@parameter.inner", "parameter")
end, { desc = "Select inner part of a parameter" })

-- Treesitter swap (needs nvim-treesitter-textobjects)
map({ "n", "x" }, "<leader>sp", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "Swap next parameter" })

map({ "n", "x" }, "<leader>sP", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, { desc = "Swap previous parameter" })

-- toggle file explorer
-- map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- toggle file explorer on current file
map("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })

map("n", "<leader>l", '<Cmd>ToggleTerm cmd="lazygit"<CR>', { desc = "Open Lazygit" })
--#endregion

map("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggles dadbod UI" })
