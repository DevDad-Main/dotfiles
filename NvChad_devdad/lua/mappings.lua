-- require "nvchad.mappings"

local M = {}

local km = vim.keymap

local function map(mode, keys, action, desc)
  desc = desc or ""
  local opts = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, keys, action, opts)
end

M.map = map

-- ============================================================================
-- Core / Basic mappings
-- ============================================================================
M.core = function()
  km.set("n", ";", ":", { desc = "CMD enter command mode" })
  km.set("i", "jj", "<ESC>")
  km.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")

  -- Move windows
  km.set("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
  km.set("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
  km.set("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
  km.set("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

  -- Move cursor when in insert mode
  map("i", "<C-h>", "<Left>")
  map("i", "<C-j>", "<Down>")
  map("i", "<C-k>", "<Up>")
  map("i", "<C-l>", "<Right>")

  -- Better scrolling with ctrl+d/u to always center the cursor on the screen
  map("n", "<C-d>", "<C-d>zz")
  map("n", "<C-u>", "<C-u>zz")

  -- Alternate file
  km.set({ "n", "x" }, "<Bslash>", "<C-6>", { desc = "Alternate File" })

  -- New splits
  km.set("n", "<Leader>ws", "<CMD>new<CR>", { desc = "New split below" })
  km.set("n", "<Leader>wv", "<CMD>vnew<CR>", { desc = "New split right" })

  -- New file / select all
  km.set("n", "<Leader>n", "<cmd>enew<CR>", { desc = "New File" })
  km.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })

  -- Yank keeps cursor
  km.set("v", "y", "ygv<Esc>", { desc = "Yank and reposition cursor" })

  -- Visual paste without overwriting register
  km.set("x", "p", function()
    return 'pgv"' .. vim.v.register .. "y"
  end, { expr = true })
end

-- ============================================================================
-- FZF-Lua
-- ============================================================================
M.fzf = function()
  local fzf = require "fzf-lua"

  map("n", "<leader>f", fzf.files, "FZF Files")
  map("n", "<leader><leader>", fzf.resume, "FZF Resume")
  map("n", "<leader>r", fzf.registers, "Registers")
  map("n", "<leader>m", fzf.marks, "Marks")
  map("n", "<leader>k", fzf.keymaps, "Keymaps")
  map("n", "<leader>z", fzf.live_grep, "FZF Grep")
  map("n", "<leader>b", fzf.buffers, "FZF Buffers")
  map("v", "<leader>8", fzf.grep_visual, "FZF Selection")
  map("n", "<leader>7", fzf.grep_cword, "FZF Word")
  map("n", "<leader>j", fzf.helptags, "Help Tags")
  map("n", "<leader>gc", fzf.git_bcommits, "Browse File Commits")
  map("n", "<leader>gs", fzf.git_status, "Git Status")
  map("n", "<leader>s", fzf.spell_suggest, "Spelling Suggestions")

  map(
    "n",
    "<leader>t",
    "<cmd>lua require('fzf-lua').grep({search='TODO|HACK|PERF|NOTE|FIX', no_esc=true})<cr>",
    "FZF Grep TODOs"
  )
end

-- ============================================================================
-- LSP / Diagnostics
-- ============================================================================
M.lsp = function()
  local fzf = require "fzf-lua"

  map("n", "<leader>cj", fzf.lsp_definitions, "Jump to Definition")
  map("n", "<leader>cr", fzf.lsp_references, "LSP References")

  map(
    "n",
    "<leader>cs",
    ":lua require'fzf-lua'.lsp_document_symbols({winopts={preview={wrap='wrap'}}})<cr>",
    "Document Symbols"
  )

  map(
    "n",
    "<leader>cd",
    ":lua require'fzf-lua'.diagnostics_document({fzf_opts={['--wrap']=true}})<cr>",
    "Document Diagnostics"
  )

  map(
    "n",
    "<leader>ca",
    ":lua require'fzf-lua'.lsp_code_actions({winopts={preview={wrap='wrap'}}})<cr>",
    "Code Actions"
  )

  map("n", "<leader>ch", vim.lsp.buf.hover, "Code Hover")
  map("n", "<leader>cl", function()
    vim.diagnostic.open_float(0, { scope = "line" })
  end, "Line Diagnostics")

  map({ "n", "v" }, "<leader>cn", vim.lsp.buf.rename, "Code Rename")
end

-- ============================================================================
-- Git
-- ============================================================================
M.git = function()
  map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", "Git toggle line blame")
  map("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", "Git preview hunk")
  map("n", "<leader>gr", ":Gitsigns reset_hunk<cr>", "Git reset hunk")
end

-- ============================================================================
-- Terminal / Snacks
-- ============================================================================
M.snacks = function()
  local exitTerm = function()
    vim.cmd ":lua Snacks.terminal.toggle()"
  end

  map("n", "<C-t>", ":lua Snacks.terminal.toggle()<cr>", "Toggle Terminal")
  map("t", "<C-t>", exitTerm)

  map("n", "<leader>l", ":lua Snacks.lazygit.open()<cr>", "Lazygit")
  map("n", "<leader>d", ":lua Snacks.bufdelete.delete()<cr>", "Buffer Delete")
  map("n", "<leader>xh", ":lua Snacks.notifier.show_history()<cr>", "Notifier history")
end

-- ============================================================================
-- Mini.nvim
-- ============================================================================
M.mini = function()
  local minipick = require "mini.pick"
  local miniextra = require "mini.extra"
  local minivisits = require "mini.visits"
  local minidiff = require "mini.diff"

  local builtin = minipick.builtin

  map("n", "<leader>ff", builtin.files, "Find files")
  map("n", "<leader>bs", builtin.buffers, "Find buffers")
  map("n", "<leader>fr", builtin.resume, "Resume finding")
  map("n", "<leader>fw", builtin.grep_live, "Grep live")

  map("n", "<leader>e", function()
    local _ = require("mini.files").close() or require("mini.files").open()
  end, "Toggle minifiles")

  map("n", "<leader>bq", function()
    require("mini.bufremove").delete()
  end, "Remove current buffer")

  map("n", "<A-s>", function()
    miniextra.pickers.visit_paths { filter = "todo" }
  end, "Add file to todolist")

  map("n", "<A-a>", function()
    minivisits.add_label "todo"
  end, "Add label to file")

  map("n", "<A-A>", function()
    minivisits.remove_label()
  end, "Remove label from file")

  map("n", "<leader>gc", miniextra.pickers.git_commits, "Show git commits")
  map("n", "<leader>gh", miniextra.pickers.git_hunks, "Show git hunks")
  map("n", "<leader>dp", miniextra.pickers.diagnostic, "Diagnostics picker")

  map("n", "<leader>td", function()
    minidiff.toggle_overlay(0)
  end, "Toggle git diff")
end

-- ============================================================================
-- Misc / UI
-- ============================================================================
M.misc = function()
  map("n", "-", function()
    vim.cmd((vim.bo.filetype == "oil") and "bd" or "Oil")
  end, "Toggle Open Oil")

  map({ "n", "v" }, "h", ":Pounce<CR>", "Pounce")
  map("n", "H", ":PounceRepeat<CR>", "Pounce Repeat")

  map("n", "<leader>tp", function()
    require("nvchad.themes").open()
  end, "NvChad Theme Picker")

  map("n", "<Leader>u", ":Lazy update<CR>", "Lazy Update (Sync)")
end

-- ============================================================================
-- Goto Preview
-- ============================================================================
M.goto_preview = function()
  local gp = require "goto-preview"

  map("n", "<leader>gpd", gp.goto_preview_definition, "Goto Preview Definition")
  map("n", "<leader>gpt", gp.goto_preview_type_definition, "Goto Preview Type Definition")
  map("n", "<leader>gpi", gp.goto_preview_implementation, "Goto Preview Implementation")
  map("n", "<leader>gpD", gp.goto_preview_declaration, "Goto Preview Declaration")
  map("n", "<leader>gpr", gp.goto_preview_references, "Goto Preview References")
  map("n", "<leader>gP", gp.close_all_win, "Goto Preview Close All Windows")
end

return M

-- -- require "nvchad.mappings"
--
-- local km = vim.keymap
--
-- local function map(mode, keys, action, desc)
--   desc = desc or ""
--   local opts = { noremap = true, silent = true, desc = desc }
--   vim.keymap.set(mode, keys, action, opts)
-- end
--
-- km.set("n", ";", ":", { desc = "CMD enter command mode" })
-- km.set("i", "jj", "<ESC>")
--
-- km.set({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- -- Original was p -> This feels more natural
-- km.set("n", "<leader>f", require("fzf-lua").files, { desc = "FZF Files" })
--
-- km.set("n", "<leader><leader>", require("fzf-lua").resume, { desc = "FZF Resume" })
--
-- km.set("n", "<leader>r", require("fzf-lua").registers, { desc = "Registers" })
--
-- km.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })
--
-- km.set("n", "<leader>k", require("fzf-lua").keymaps, { desc = "Keymaps" })
--
-- -- Original was f -> This feels more natural
-- km.set("n", "<leader>z", require("fzf-lua").live_grep, { desc = "FZF Grep" })
--
-- km.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "FZF Buffers" })
--
-- km.set("v", "<leader>8", require("fzf-lua").grep_visual, { desc = "FZF Selection" })
--
-- km.set("n", "<leader>7", require("fzf-lua").grep_cword, { desc = "FZF Word" })
--
-- km.set("n", "<leader>j", require("fzf-lua").helptags, { desc = "Help Tags" })
--
-- km.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })
--
-- km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })
--
-- km.set("n", "<leader>s", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })
--
-- km.set("n", "<leader>cj", require("fzf-lua").lsp_definitions, { desc = "Jump to Definition" })
--
-- km.set(
--   "n",
--   "<leader>cs",
--   ":lua require'fzf-lua'.lsp_document_symbols({winopts = {preview={wrap='wrap'}}})<cr>",
--   { desc = "Document Symbols" }
-- )
--
-- km.set("n", "<leader>cr", require("fzf-lua").lsp_references, { desc = "LSP References" })
--
-- km.set(
--   "n",
--   "<leader>cd",
--   ":lua require'fzf-lua'.diagnostics_document({fzf_opts = { ['--wrap'] = true }})<cr>",
--   { desc = "Document Diagnostics" }
-- )
--
-- km.set(
--   "n",
--   "<leader>ca",
--   -- ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
--   ":lua require'fzf-lua'.lsp_code_actions({ winopts = {preview={wrap='wrap'}}})<cr>",
--   { desc = "Code Actions" }
-- )
--
-- km.set("n", "<leader>ch", function()
--   vim.lsp.buf.hover()
-- end, { desc = "Code Hover" })
--
-- km.set("n", "<leader>cl", function()
--   vim.diagnostic.open_float(0, { scope = "line" })
-- end, { desc = "Line Diagnostics" })
--
-- km.set({ "v", "n" }, "<leader>cn", function()
--   vim.lsp.buf.rename()
-- end, { noremap = true, silent = true, desc = "Code Rename" })
--
-- -- Move Windows
-- km.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Window Left" })
-- km.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Window Down" })
-- km.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Window Up" })
-- km.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Window Right" })
--
-- -- Gitsigns specific for file specific git info/tools
-- km.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Git toggle line blame" })
-- km.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
-- km.set("n", "<leader>gr", ":Gitsigns reset_hunk<cr>", { desc = "Get reset hunk" })
--
-- -- Search Available Sessions
-- km.set("n", "<Leader>xs", ":AutoSession search<CR>", { desc = "Search Sessions" })
--
-- -- This allows you to select, and pte over contents, without that pasted over contents going into the register, that means you can paste again without it inserting the thing you pasted over the last time
-- km.set("x", "p", function()
--   return 'pgv"' .. vim.v.register .. "y"
-- end, { remap = false, expr = true })
--
-- -- Switch Back to the previous file
-- km.set({ "n", "x" }, "<Bslash>", "<C-6>", { desc = "Alternate File" })
--
-- -- Quick new split above/below
-- km.set({ "n" }, "<Leader>ws", "<CMD>new<CR>", { desc = "New split below" })
-- km.set({ "n" }, "<Leader>wv", "<CMD>vnew<CR>", { desc = "New split right" })
--
-- -- Toggle Terminal, thanks https://www.reddit.com/r/neovim/comments/1bjhadj/efficiently_switching_between_neovim_and_terminal/
-- exitTerm = function()
--   vim.cmd ":lua Snacks.terminal.toggle()"
-- end
-- km.set({ "n" }, "<C-t>", ":lua Snacks.terminal.toggle()<cr>", { desc = "Toggle Terminal" })
-- km.set({ "t" }, "<C-t>", exitTerm)
--
-- km.set("n", "<leader>l", ":lua Snacks.lazygit.open()<cr>", { silent = true, desc = "Lazygit" })
--
-- -- Easy delete buffer without losing window split
-- km.set("n", "<leader>d", ":lua Snacks.bufdelete.delete()<cr>", { silent = true, desc = "Buffer Delete" })
--
-- -- Show Notifier history
-- km.set("n", "<leader>xh", ":lua Snacks.notifier.show_history()<cr>", { silent = true, desc = "Notifier history" })
--
-- -- Toggle Open Oil
-- km.set("n", "-", function()
--   vim.cmd((vim.bo.filetype == "oil") and "bd" or "Oil")
-- end, { desc = "Toggle Open Oil" })
--
-- -- Use FZF-lua to search for TODOs
-- km.set(
--   "n",
--   "<leader>t",
--   "<cmd>:lua require('fzf-lua').grep({search='TODO|HACK|PERF|NOTE|FIX', no_esc=true}) <cr>",
--   { desc = "FZF Grep TODOs" }
-- )
--
-- km.set({ "n", "v" }, "h", ":Pounce<CR>", { silent = true, desc = "Pounce" })
-- km.set("n", "H", ":PounceRepeat<CR>", { silent = true, desc = "Pounce Repeat" })
--
-- -- NvChad theme picker
-- km.set("n", "<leader>tp", function()
--   require("nvchad.themes").open()
-- end, { desc = "NvChad Theme Picker" })
--
-- -- Goto Preview
-- km.set(
--   "n",
--   "<leader>gpd",
--   "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
--   { desc = "Goto Preview Definition" }
-- )
-- km.set(
--   "n",
--   "<leader>gpt",
--   "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
--   { desc = "Goto Preview Type Definition" }
-- )
-- km.set(
--   "n",
--   "<leader>gpi",
--   "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
--   { desc = "Goto Preview Implementation" }
-- )
-- km.set(
--   "n",
--   "<leader>gpD",
--   "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
--   { desc = "Goto Preview Declaration" }
-- )
-- km.set(
--   "n",
--   "<leader>gP",
--   "<cmd>lua require('goto-preview').close_all_win()<CR>",
--   { desc = "Goto Preview Close All Windows" }
-- )
-- km.set(
--   "n",
--   "<leader>gpr",
--   "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
--   { desc = "Goto Preview References" }
-- )
--
-- km.set("n", "<Leader>u", ":Lazy update<CR>", { desc = "Lazy Update (Sync)" })
--
-- km.set("n", "<Leader>n", "<cmd>enew<CR>", { desc = "New File" })
--
-- km.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })
--
-- -- Make visual yanks place the cursor back where started
-- km.set("v", "y", "ygv<Esc>", { desc = "Yank and reposition cursor" })
--
-- local M = {}
--
-- M.map = map
--
-- -- Returns a function that setups the mini.nvim plugins keymaps
-- M.mini = function()
--   local minipick = require "mini.pick"
--   local miniextra = require "mini.extra"
--   local minivisits = require "mini.visits"
--   local minidiff = require "mini.diff"
--
--   local builtin = minipick.builtin
--
--   map({ "n" }, "<leader>ff", function()
--     builtin.files()
--   end, "find files")
--
--   map({ "n" }, "<leader>bs", function()
--     builtin.buffers()
--   end, "Find buffers")
--
--   map({ "n" }, "<leader>fr", function()
--     builtin.resume()
--   end, "Resume finding")
--
--   map({ "n" }, "<leader>fw", function()
--     builtin.grep_live()
--   end, "Grep live")
--
--   map({ "n" }, "<leader>e", function()
--     local _ = require("mini.files").close() or require("mini.files").open()
--   end, "Toggle minifiles")
--
--   map({ "n" }, "<leader>bq", function()
--     require("mini.bufremove").delete()
--   end, "Remove current buffer")
--
--   map("n", "<A-s>", function()
--     miniextra.pickers.visit_paths { filter = "todo" }
--   end, "Add file to todolist")
--
--   map("n", "<A-a>", function()
--     minivisits.add_label "todo"
--   end, "Remove file from todolist")
--
--   map("n", "<A-A>", function()
--     minivisits.remove_label()
--   end, "Remove label from file")
--
--   map("n", "<leader>gc", function()
--     miniextra.pickers.git_commits()
--   end, "Show git commits")
--
--   map("n", "<leader>gh", function()
--     miniextra.pickers.git_hunks()
--   end, "Show git hunks")
--
--   map("n", "<leader>dp", function()
--     miniextra.pickers.diagnostic()
--   end, "Diagnostic in picker")
--
--   map("n", "<leader>td", function()
--     minidiff.toggle_overlay(0)
--   end, "Toggle git diff")
-- end
--
-- return M
