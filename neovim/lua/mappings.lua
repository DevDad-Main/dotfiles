local km = vim.keymap

-- Here is a utility function that closes any floating windows when you press escape
local function close_floating()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

local function open_minifiles_in_cwd()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
  if vim.fn.filereadable(buf_name) == 1 then
    -- Pass the full file path to highlight the file
    require("mini.files").open(buf_name, true)
  elseif vim.fn.isdirectory(dir_name) == 1 then
    -- If the directory exists but the file doesn't, open the directory
    require("mini.files").open(dir_name, true)
  else
    -- If neither exists, fallback to the current working directory
    require("mini.files").open(vim.uv.cwd(), true)
  end
end

--  ┌                                                                              ┐
--  │ These define common comment styles like this                                 │
--  └                                                                              ┘
km.set({ "n", "v" }, "<leader>x1", ":CBlabox<cr>", { desc = "Comment - Box Around Code" })
-- km.set({ "n", "v" }, "<leader>x2", ":CBlbox18<cr>", { desc = "Comment - both sides" })
km.set("n", "<leader>x3", "CBline3<cr>", { desc = "Centered Line" })
km.set("n", "<leader>x4", "CBline5<cr>", { desc = "Centered Line Weighted" })

km.set("n", "<Leader>u", ":Lazy update<CR>", { desc = "Lazy Update (Sync)" })

km.set("n", "<Leader>n", "<cmd>enew<CR>", { desc = "New File" })

km.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })

-- Make visual yanks place the cursor back where started
km.set("v", "y", "ygv<Esc>", { desc = "Yank and reposition cursor" })

km.set("n", "<Delete>", "<cmd>:w<CR>", { desc = "Save file" })

km.set("n", "<leader>xu", ":UndotreeToggle<cr>", { desc = "Undo Tree" })

-- NvChad theme picker
km.set("n", "<leader>tp", function()
  require("nvchad.themes").open()
end, { desc = "NvChad Theme Picker" })

-- Theme toggling mappings
km.set("n", "<leader>tt", function()
  require("configs.nvchad").toggle_theme()
end, { desc = "Toggle Theme" })

km.set("n", "<leader>tn", function()
  require("configs.nvchad").set_theme("nord")
end, { desc = "Set Nord Theme" })


-- More molecular undo of text
km.set("i", ".", ".<c-g>u")
km.set("i", "!", "!<c-g>u")
km.set("i", "?", "?<c-g>u")
km.set("i", ";", ";<c-g>u")
km.set("i", ":", ":<c-g>u")

km.set({ "n", "i" }, "<F1>", "<Esc>")

--nav buddy
km.set({ "n" }, "<leader>xb", ":lua require('nvim-navbuddy').open()<cr>", { desc = "Nav Buddy" })

km.set("n", "<esc>", function()
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

-- Easy add date/time
function date()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_feedkeys("o", "n", true)
end

km.set("n", "<Leader>xd", "<cmd>lua date()<cr>", { desc = "Insert Date" })

km.set("n", "<Leader>v", "gea", { desc = "Edit after last word" })

km.set("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true, desc = "if j > 5 add to jumplist" })

-- Original was p -> This feels more natural
km.set("n", "<leader>f", require("fzf-lua").files, { desc = "FZF Files" })

km.set("n", "<leader><leader>", require("fzf-lua").resume, { desc = "FZF Resume" })

km.set("n", "<leader>r", require("fzf-lua").registers, { desc = "Registers" })

km.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })

km.set("n", "<leader>k", require("fzf-lua").keymaps, { desc = "Keymaps" })

-- Original was f -> This feels more natural
km.set("n", "<leader>z", require("fzf-lua").live_grep, { desc = "FZF Grep" })

km.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "FZF Buffers" })

km.set("v", "<leader>8", require("fzf-lua").grep_visual, { desc = "FZF Selection" })

km.set("n", "<leader>7", require("fzf-lua").grep_cword, { desc = "FZF Word" })

km.set("n", "<leader>j", require("fzf-lua").helptags, { desc = "Help Tags" })

km.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })

km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })

km.set("n", "<leader>s", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })

km.set("n", "<leader>cj", require("fzf-lua").lsp_definitions, { desc = "Jump to Definition" })

km.set(
  "n",
  "<leader>cs",
  ":lua require'fzf-lua'.lsp_document_symbols({winopts = {preview={wrap='wrap'}}})<cr>",
  { desc = "Document Symbols" }
)

km.set("n", "<leader>cr", require("fzf-lua").lsp_references, { desc = "LSP References" })

km.set(
  "n",
  "<leader>cd",
  ":lua require'fzf-lua'.diagnostics_document({fzf_opts = { ['--wrap'] = true }})<cr>",
  { desc = "Document Diagnostics" }
)

km.set(
  "n",
  "<leader>ca",
  -- ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
  ":lua require'fzf-lua'.lsp_code_actions({ winopts = {preview={wrap='wrap'}}})<cr>",
  { desc = "Code Actions" }
)

km.set("n", "<leader>ch", function()
  vim.lsp.buf.hover()
end, { desc = "Code Hover" })

km.set("n", "<leader>cl", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Line Diagnostics" })

km.set({ "v", "n" }, "<leader>cn", function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "Code Rename" })

km.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Window Left" })
km.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Window Down" })
km.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Window Up" })
km.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Window Right" })
-- NOTE: For Users who like to use arrow keys
-- km.set("n", "<Leader><Down>", "<C-W><C-J>", { silent = true, desc = "Window Down" })
-- km.set("n", "<Leader><Up>", "<C-W><C-K>", { silent = true, desc = "Window Up" })
-- km.set("n", "<Leader><Right>", "<C-W><C-L>", { silent = true, desc = "Window Right" })
-- km.set("n", "<Leader><Left>", "<C-W><C-H>", { silent = true, desc = "Window Left" })
km.set("n", "<Leader>wr", "<C-W>R", { silent = true, desc = "Window Resize" })
km.set("n", "<Leader>=", "<C-W>=", { silent = true, desc = "Window Equalise" })

-- Easier window switching with leader + Number
-- Creates mappings like this: km.set("n", "<Leader>2", "2<C-W>w", { desc = "Move to Window 2" })
for i = 1, 4 do
  local lhs = "<Leader>" .. i
  local rhs = i .. "<C-W>w"
  km.set("n", lhs, rhs, { desc = "Move to Window " .. i })
end

km.set({ "n", "v" }, "h", ":Pounce<CR>", { silent = true, desc = "Pounce" })
km.set("n", "H", ":PounceRepeat<CR>", { silent = true, desc = "Pounce Repeat" })

km.set("i", "<A-BS>", "<C-W>", { desc = "Option+BS deletes whole word" })

-- Gitsigns specific for file specific git info/tools
km.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Git toggle line blame" })
km.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
km.set("n", "<leader>gr", ":Gitsigns reset_hunk<cr>", { desc = "Get reset hunk" })

km.set("n", "<Leader>xs", ":SearchSession<CR>", { desc = "Search Sessions" })

km.set(
  "v",
  "<leader>xp",
  ":'<,'> w !pandoc --no-highlight --wrap=none | pbcopy <CR>",
  { silent = true, desc = "Pandoc Export" }
)

km.set("n", "<Leader>xn", ":let @+=@%<cr>", { desc = "Copy Buffer name and path" })

km.set("n", "<Leader>xc", ":g/console.lo/d<cr>", { desc = "Remove console.log" })

km.set("v", "<leader>o", "zA", { desc = "Toggle Fold" })


km.set({ "n", "x" }, "[p", '<Cmd>exe "put! " . v:register<CR>', { desc = "Paste Above" })
km.set({ "n", "x" }, "]p", '<Cmd>exe "put "  . v:register<CR>', { desc = "Paste Below" })

-- This allows you to select, and paste over contents, without that pasted over contents going into the register, that means you can paste again without it inserting the thing you pasted over the last time
km.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

km.set({ "n", "x" }, "<Bslash>", "<C-6>", { desc = "Alternate File" })
-- This sets the ability to surround words with brackets and quotes with one key in visual mode
-- local v_chars = { "(", ")", "[", "]", "{", "}", "'", '"' }
-- for _, char in pairs(v_chars) do
--   vim.keymap.set("v", char, "<Plug>(nvim-surround-visual)" .. char)
-- end
--
-- Set file EOL
km.set({ "n" }, "<Leader>xl", ":set ff=dos<CR>", { desc = "EOL = CRLF" })
km.set({ "n" }, "<Leader>xf", ":set ff=unix<CR>", { desc = "EOL = LF" })

-- Quick new split above/below
km.set({ "n" }, "<Leader>ws", "<CMD>new<CR>", { desc = "New split below" })
km.set({ "n" }, "<Leader>wv", "<CMD>vnew<CR>", { desc = "New split right" })

km.set({ "n" }, "<Leader>xw", function()
  return Snacks.notify.notify(wordCount.getWords(), {
    zindex = 1000,
    title = "Word Count",
    timeout = 3000,
    icon = "󰆙 ",
  })
end, { desc = "Word Count" })

-- get the file format of the current file
km.set({ "n" }, "<Leader>xt", function()
  local symbols = {
    unix = " LF",
    dos = " CRLF",
    mac = " CR",
  }

  local ft = vim.bo.fileformat
  local output = string.format("%s%s", ft, symbols[ft])
  return Snacks.notify.notify(output, {
    icon = " ",
    title = "File Type",
    timeout = 2000,
    zindex = 1000,
  })
end, { desc = "Show File Format" })

-- Toggle Terminal, thanks https://www.reddit.com/r/neovim/comments/1bjhadj/efficiently_switching_between_neovim_and_terminal/
exitTerm = function()
  vim.cmd(":lua Snacks.terminal.toggle()")
end
km.set({ "n" }, "<C-t>", ":lua Snacks.terminal.toggle()<cr>", { desc = "Toggle Terminal" })
km.set({ "t" }, "<C-t>", exitTerm)

-- km.set("n", "<leader>l", ":LazyGit<cr>", { silent = true, desc = "Lazygit" })
km.set("n", "<leader>l", ":lua Snacks.lazygit.open()<cr>", { silent = true, desc = "Lazygit" })

-- Easy delete buffer without losing window split
km.set("n", "<leader>d", ":lua Snacks.bufdelete.delete()<cr>", { silent = true, desc = "Buffer Delete" })

-- Zen Mode -- NOTE: Uncomment if you want to use it
-- Snacks.toggle.zen():map("<leader>z")

-- Show Notifier history
km.set("n", "<leader>xh", ":lua Snacks.notifier.show_history()<cr>", { silent = true, desc = "Notifier history" })

km.set("n", "<leader>gf", ":! git checkout -- % <cr>", { silent = true, desc = "Chechout current file" })

km.set("i", "jj", "<ESC><ESC>", { desc = "Alternative to Enter Normal Mode" })

-- Map Save even when in insert mode
km.set("i", "<C-S>", "<Cmd>w<CR><ESC>", { desc = "Save file" })

-- Togggle Lsp Inlay hints with custom Command -> usercmd.lua
km.set("n", "<leader>h", "<cmd>ToggleInlayHints<cr>", { desc = "Toggle Inlay Hints" })

-- Neo Test - Whole File
km.set("n", "<leader>nt", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "󰤑 Run All Tests In File" })

-- Neo Test - Whole File
km.set("n", "<leader>nts", function()
  require("neotest").run.stop()
end, { desc = "󰤑 Stop Nearest Neotest" })

km.set("n", "<leader>nto", "<cmd>Neotest summary<cr>", { desc = "󰤑 Open Neotest Summary" })

-- Neo Test - Run Hovered Over Test
km.set("n", "<leader>rt", function()
  require("neotest").run.run()
end, { desc = "󰤑 Run Nearest Test" })

-- Toggle Open Oil
km.set("n", "-", function()
  vim.cmd((vim.bo.filetype == "oil") and "bd" or "Oil")
end, { desc = "Toggle Open Oil" })

-- Use FZF-lua to search for TODOs
km.set(
  "n",
  "<leader>t",
  "<cmd>:lua require('fzf-lua').grep({search='TODO|HACK|PERF|NOTE|FIX', no_esc=true}) <cr>",
  { desc = "FZF Grep TODOs" }
)

-- Open Mini.files where your file is - cwd
km.set("n", "<leader>e", function()
  open_minifiles_in_cwd()
end, { desc = "Open MiniFiles" })

-- Toggle tree
km.set("n", "<leader>-", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle NvimTree" })

km.set("n", "<leader>gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
  { desc = "Goto Preview Definition" })
km.set("n", "<leader>gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
  { desc = "Goto Preview Type Definition" })
km.set("n", "<leader>gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
  { desc = "Goto Preview Implementation" })
km.set("n", "<leader>gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
  { desc = "Goto Preview Declaration" })
km.set("n", "<leader>gP", "<cmd>lua require('goto-preview').close_all_win()<CR>",
  { desc = "Goto Preview Close All Windows" })
km.set("n", "<leader>gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
  { desc = "Goto Preview References" })
