--#region Options
vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])
vim.cmd([[hi @lsp.type.number gui=italic]])

vim.opt.winborder = "none"
-- vim.opt.winborder = "single"
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 1
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.number = true
vim.opt.termguicolors = true

-- Enable ufo folds
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.require'ufo'.foldexpr()"
vim.opt.cmdheight = 0

vim.o.updatetime = 250
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.o.autoread = true
vim.g.mapleader = " "
vim.opt.fillchars:append({ eob = " " })
-- vim.g.mapleader = ","

-- UFO configuration is handled in options/basic.lua
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  -- local suffix = ("  %d lines"):format(endLnum - lnum)
  local suffix = ("  "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "UfoFoldedEllipsis" })
  return newVirtText
end
--#endregion

--#region Package Installer
vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/chentoast/marks.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/aznhe21/actions-preview.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/LinArcX/telescope-env.nvim" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
  { src = "https://github.com/julianolf/nvim-dap-lldb" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/kevinhwang91/promise-async" },
  { src = "https://github.com/kevinhwang91/nvim-ufo" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/dmtrKovalenko/fff.nvim" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/xzbdmw/colorful-menu.nvim" },
})
--#endregion

--#region Package Management
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

-- the plugin will automatically lazy load
require("fff").setup({
  title = "Files",
  prompt = " ",
  lazy_sync = true, -- start syncing only when the picker is open
  debug = {
    enabled = true,
    show_scores = true,
  },
  layout = {
    height = 1,
    width = 1,
    prompt_position = "top", -- or 'top'
    preview_position = "right", -- or 'left', 'right', 'top', 'bottom'
    preview_size = 0.4,
    show_scrollbar = false, -- Show scrollbar for pagination
  },
  keymaps = {
    close = "<Esc>",
    select = "<CR>",
    select_split = "<C-s>",
    select_vsplit = "<C-v>",
    select_tab = "<C-t>",
    -- you can assign multiple keys to any action
    move_up = { "<Up>", "<C-p>", "<C-k>" },
    move_down = { "<Down>", "<C-n>", "<C-j>" },
    preview_scroll_up = "<C-u>",
    preview_scroll_down = "<C-d>",
    toggle_debug = "<F2>",
    -- goes to the previous query in history
    cycle_previous_query = "<C-Up>",
    -- multi-select keymaps for quickfix
    toggle_select = "<Tab>",
    send_to_quickfix = "<C-q>",
  },
  hl = {
    border = "none",
  },
})

require("todo-comments").setup()

require("dap-lldb").setup()
local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set({ "n" }, "<Leader>nd", ":DapNew<CR>")
vim.keymap.set({ "n", "i" }, "<C-b>", ":DapToggleBreakpoint<CR>")

require("marks").setup({
  builtin_marks = { "<", ">", "^" },
})

-- Custom Snippets if needed
require("luasnip.loaders.from_lua").load({
  paths = "~/.config/nvim/snippets/",
})

-- Load vscode snippets
require("luasnip.loaders.from_vscode").lazy_load()

local has_colorful = pcall(require, "colorful-menu")
local colorful = has_colorful and require("colorful-menu") or nil

require("blink.cmp").setup({
  appearance = {
    use_nvim_cmp_as_default = false,

    -- Minimal Nerd Font icons (tight + readable)
    kind_icons = {
      Text = "󰦨 ",
      Method = "󰆧 ",
      Function = "󰊕 ",
      Constructor = "󰒓 ",
      Field = "󰜢 ",
      Variable = "󰀫",
      Class = "󰠱 ",
      Interface = "󰠱 ",
      Module = "󰅩 ",
      Property = "󰜢 ",
      Unit = "󰑭 ",
      Value = "󰎠 ",
      Enum = "󰕘 ",
      Keyword = "󰌋 ",
      Snippet = "󰩫 ",
      Color = "󰏘 ",
      File = "󰈙 ",
      Reference = "󰈇 ",
      Folder = "󰉋 ",
      EnumMember = "󰕘 ",
      Constant = "󰏿 ",
      Struct = "󰠱 ",
      Event = "󰉁",
      Operator = "󰆕 ",
      TypeParameter = "󰊄 ",
    },
  },

  completion = {
    menu = {
      border = "none",
      scrollbar = false,
      draw = {
        -- We don't need label_description now because label and label_description are already
        -- combined together in label by colorful-menu.nvim.
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          label = {
            width = { fill = true, max = 60 },
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },

    documentation = {
      window = { border = "none" },
      auto_show_delay_ms = 500,
    },

    signature = {
      window = { border = "none" },
    },
  },

  -- completion = {
  --   menu = {
  --     border = "none",
  --     scrollbar = false,
  --     draw = {
  --       columns = {
  --         { "label",     "label_description" }, -- label_description will show module info
  --         { "kind_icon", "kind",             gap = 1, hl = "BlinkCmpKind" },
  --       },
  --     },
  --   },
  --
  --   documentation = {
  --     window = { border = "none" },
  --     auto_show_delay_ms = 500,
  --   },
  --
  --   signature = {
  --     window = { border = "none" },
  --   },
  -- },

  keymap = {
    ["<C-e>"] = { "select_and_accept" },
    ["<C-j>"] = { "select_next" },
    ["<C-k>"] = { "select_prev" },
    ["<CR>"] = { "accept", "fallback" },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = {
        async = true, -- makes completion faster
        fallbacks = { "buffer" }, -- fallback if LSP fails
      },
    },
  },

  signature = {
    enabled = true,
    window = { border = "none" },
  },
})

-- require("blink.cmp").setup({
--   appearance = {
--     use_nvim_cmp_as_default = false,
--
--     -- Minimal Nerd Font icons (tight + readable)
--     kind_icons = {
--       Text = "󰦨 ",
--       Method = "󰆧 ",
--       Function = "󰊕 ",
--       Constructor = "󰒓 ",
--       Field = "󰜢 ",
--       Variable = "󰀫",
--       Class = "󰠱 ",
--       Interface = "󰠱 ",
--       Module = "󰅩 ",
--       Property = "󰜢 ",
--       Unit = "󰑭 ",
--       Value = "󰎠 ",
--       Enum = "󰕘 ",
--       Keyword = "󰌋 ",
--       Snippet = "󰩫 ",
--       Color = "󰏘 ",
--       File = "󰈙 ",
--       Reference = "󰈇 ",
--       Folder = "󰉋 ",
--       EnumMember = "󰕘 ",
--       Constant = "󰏿 ",
--       Struct = "󰠱 ",
--       Event = "󰉁",
--       Operator = "󰆕 ",
--       TypeParameter = "󰊄 ",
--     },
--   },
--
--   completion = {
--     menu = {
--       border = "none",
--       scrollbar = false,
--       draw = {
--         columns = {
--           { "label", "label_description" },
--           {
--             "kind_icon",
--             "kind",
--             gap = 1,
--             hl = "BlinkCmpKind",
--           },
--         },
--       },
--     },
--
--     documentation = {
--       window = { border = "none" },
--     },
--
--     signature = {
--       window = { border = "none" },
--     },
--   },
--
--   keymap = {
--     ["<C-e>"] = { "select_and_accept" },
--     ["<C-j>"] = { "select_next" },
--     ["<C-k>"] = { "select_prev" },
--     ["<CR>"] = { "accept", "fallback" },
--   },
--
--   sources = {
--     default = {
--       "lsp",
--       "snippets",
--       "buffer",
--       "path",
--     },
--   },
--
--   signature = {
--     enabled = true,
--     window = { border = "none" },
--   },
-- })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", stop_after_first = true },
    -- javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", stop_after_first = true },
    typescriptreact = { "prettierd", stop_after_first = true },
    typescript = { "prettierd", "prettier" },
    java = { "google-java-format", stop_after_first = true },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    graphql = { "prettierd", "prettier" },
    md = { "prettierd", "prettier" },
    txt = { "prettierd", "prettier" },
  },
  formatters = {
    stylua = {
      args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
    },
    prettier = {
      require_cwd = true,
      cwd = require("conform.util").root_file({
        "package.json",
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.mjs",
        ".prettierrc.toml",
        "prettier.config.js",
        "prettier.config.cjs",
        "prettier.config.mjs",
      }),
    },
  },
  -- Set up format-on-save
  -- don't want it formatting with lsp if Prettier isn't available
  format_on_save = { timeout_ms = 1500, lsp_format = "never" },
})

require("ufo").setup({
  -- NOTE: Uncomment to enable folding for other Filetypes
  close_fold_kinds_for_ft = {
    default = { "imports", "comment", "region" },
    json = { "array" },
    c = { "comment", "region" },
    javascript = { "region", "comment" },
  },
  fold_virt_text_handler = handler,
  open_fold_hl_timeout = 0,
  preview = {
    win_config = {
      border = "rounded",
      winblend = 15,
    },
  },
  provider_selector = function(_, filetype, buftype)
    -- use nested markdown folding
    if filetype == "markdown" then
      return ""
    end

    -- return ftMap[filetype] or { "treesitter", "indent" }
    -- return { "treesitter", "indent" }
    local function handleFallbackException(bufnr, err, providerName)
      if type(err) == "string" and err:match("UfoFallbackException") then
        return require("ufo").getFolds(bufnr, providerName)
      else
        return require("promise").reject(err)
      end
    end

    -- only use indent until a file is opened
    return (filetype == "" or buftype == "nofile") and "indent"
      or function(bufnr)
        return require("ufo")
          .getFolds(bufnr, "lsp")
          :catch(function(err)
            return handleFallbackException(bufnr, err, "treesitter")
          end)
          :catch(function(err)
            return handleFallbackException(bufnr, err, "indent")
          end)
      end
  end,
})

require("nvim-treesitter").setup({
  -- parsers to install
  ensure_installed = { "typescript", "tsx", "javascript", "lua", "json" },

  highlight = {
    enable = true,
  },

  -- add other modules here if needed
})

-- Mason LSP/tools installed
--   ◍ stylua
--  ◍ lua-language-server
--  ◍ prettierd
--  ◍ vtsls
require("mason").setup()

local telescope = require("telescope")
local actions = require("telescope.actions")

local default_color = "vague"

telescope.setup({
  defaults = {
    preview = { treesitter = false },
    color_devicons = true,
    sorting_strategy = "ascending",
    borderchars = {
      "", -- top
      "", -- right
      "", -- bottom
      "", -- left
      "", -- top-left
      "", -- top-right
      "", -- bottom-right
      "", -- bottom-left
    },
    path_displays = { "smart" },
    layout_config = {
      height = 100,
      width = 400,
      prompt_position = "top",
      preview_cutoff = 40,
    },

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<Esc>"] = actions.close,
        ["<C-x>"] = actions.delete_buffer, -- Come from fzf-lua and this is natural
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["dd"] = actions.delete_buffer,
      },
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      ignore_current_buffer = false,
    },
  },
})

telescope.load_extension("ui-select")

require("actions-preview").setup({
  backend = { "telescope" },
  extensions = { "env" },
  telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {}),
})

-- Old Way to enable all suggestions with pumb
-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	group = vim.api.nvim_create_augroup('my.lsp', {}),
-- 	callback = function(args)
-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
-- 		if client:supports_method('textDocument/completion') then
-- 			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
-- 			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
-- 			client.server_capabilities.completionProvider.triggerCharacters = chars
-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })

vim.lsp.enable({
  "lua_ls",
  "cssls",
  "svelte",
  "tinymist",
  "rust_analyzer",
  "clangd",
  "ruff",
  "glsl_analyzer",
  "haskell-language-server",
  "hlint",
  "intelephense",
  "tailwindcss",
  "vtsls",
  "ts_ls",
  "emmet_language_server",
  "emmet_ls",
  "solargraph",
  "zls",
  "pyright",
})

require("oil").setup({
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = true,
  },
  view_options = {
    show_hidden = true,
  },
  columns = {
    "icon",
  },
  float = {
    max_width = 0,
    max_height = 0,
    border = "rounded",
  },
})

require("vague").setup({ transparent = true })
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
--#endregion

--#region KeyMaps
local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

vim.keymap.set("n", "<leader>pc", pack_clean)
local colors = {}
local ls = require("luasnip")
local builtin = require("telescope.builtin")
local map = vim.keymap.set
local current = 1

local map = vim.keymap.set

function safe_require(module)
  local ok, mod = pcall(require, module)
  return ok and mod or nil
end

local builtin = safe_require("telescope.builtin")
local ls = safe_require("luasnip")

map({ "n", "x" }, "<leader>y", '"+y')
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
map({ "n" }, "<C-t>", "<Cmd>tabnew<CR>")
map({ "n" }, "<C-x>", "<Cmd>tabclose<CR>")

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

for i = 1, 8 do
  map({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

map({ "n", "v", "x" }, "<leader>v", "<Cmd>edit $MYVIMRC<CR>", { desc = "Edit " .. vim.fn.expand("$MYVIMRC") })
map({ "n", "v", "x" }, "<leader>z", "<Cmd>e ~/.zshrc<CR>", { desc = "Edit .zshrc" })
map({ "n", "v", "x" }, "<leader>n", ":norm ", { desc = "ENTER NORM COMMAND." })
map({ "n", "v", "x" }, "<leader>o", ":update<CR> :source<CR>", { desc = "Source " })
map({ "n", "v", "x" }, "<leader>O", "<Cmd>restart<CR>", { desc = "Restart vim." })
map({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Enter substitue mode in selection" })
-- map({ "n", "v", "x" }, "<leader>m", vim.lsp.buf.format, { desc = "Format current buffer" })
map({ "n", "v", "x" }, "<leader>m", "<Cmd>Format<CR>", { desc = "Format current buffer" })
map({ "v", "x", "n" }, "<C-y>", '"+y', { desc = "System clipboard yank." })

if builtin then
  -- NOTE: Use fff instead for the buillin frecency
  -- map({ "n" }, "<leader>f", builtin.find_files, { desc = "Telescope live grep" })
  map({ "n" }, "<leader>g", builtin.live_grep)
  -- NOTE: Technically not builtin but it's apart of the Telecope family.
  map({ "n" }, "<leader>t", "<CMD>:TodoTelescope<CR>")
  map({ "n" }, "<leader>b", builtin.buffers, { desc = "Telescope open buffers" })
  map({ "n" }, "<leader>si", builtin.grep_string, { desc = "Telescope grep word" })
  map({ "n" }, "<leader>so", builtin.oldfiles, { desc = "Telescope search old(recent) files" })
  map({ "n" }, "<leader>sh", builtin.help_tags, { desc = "Telescope open help tags" })
  map({ "n" }, "<leader>sm", builtin.man_pages, { desc = "Telescope open manaul(:man)" })
  map({ "n" }, "<leader>sr", builtin.lsp_references, { desc = "Telescope show LSP references" })
  map({ "n" }, "<leader>sd", builtin.lsp_definitions, { desc = "Telescope definitions" })
  map({ "n" }, "<leader>sD", builtin.diagnostics, { desc = "Telescope Show Siagnostics" })
  map({ "n" }, "<leader>sT", builtin.lsp_type_definitions, { desc = "Telescope LSP Definitions" })
  map({ "n" }, "<leader>ss", builtin.current_buffer_fuzzy_find, { desc = "Telescope Fzf current Buffer" })
  map({ "n" }, "<leader>st", builtin.builtin, { desc = "Telescope Builtin Actions" })
  map({ "n" }, "<leader>sc", builtin.git_bcommits, { desc = "Telescope Git Commits" })
  map({ "n" }, "<leader>sk", builtin.keymaps, { desc = "Telescope Keymaps" })
end

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

local actions_preview = safe_require("actions-preview")
if actions_preview then
  map({ "n" }, "<leader>sa", actions_preview.code_actions)
end

-- Resize splits using Alt + hjkl
map("n", "<M-h>", "<cmd>vertical resize -5<CR>") -- narrower
map("n", "<M-l>", "<cmd>vertical resize +5<CR>") -- wider
map("n", "<M-j>", "<cmd>resize +2<CR>") -- taller
map("n", "<M-k>", "<cmd>resize -2<CR>") -- shorter

-- Toggle Open Oil In Float Mode
map("n", "<leader>e", function()
  vim.cmd((vim.bo.filetype == "oil") and "bd" or "Oil --float")
end, { desc = "Toggle Open Oil" })

map({ "n" }, "<leader>c", "1z=")
map({ "n" }, "<C-q>", ":copen<CR>", { silent = true })
map({ "n" }, "<leader>w", "<Cmd>update<CR>", { desc = "Write the current buffer." })
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })
map({ "n" }, "<C-f>", "<Cmd>Open .<CR>", { desc = "Open current directory in Finder." })
map({ "n" }, "<leader>a", ":edit #<CR>", { desc = "Open current directory in Finder." })

map("n", "<C-d>", "<C-d>zz", { desc = "Better default Ctrl-d but centers screen" })
map("n", "<C-u>", "<C-u>zz", { desc = "Better default Ctrl-u but centers screen" })
map("n", "n", "nzzzv", { desc = "Better 'n' for '/' search, centers screen and open folds" })
map("n", "N", "Nzzzv", { desc = "Better 'N' for '/' search, centers screen and open folds" })

-- Completion
map("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true, silent = true })

map("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true, silent = true })

map("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })

-- Remove Search Highlighting, Dismiss Popups
map("n", "<esc>", function()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

map("n", "<leader>wv", "<Cmd>:vsplit<CR>", { desc = "Opens a buffer in a horizontal split" })
map("n", "<leader>ws", "<Cmd>:split<CR>", { desc = "Opens a buffer in a vertical split" })

map("n", "<leader>h", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggles Inlay Hints" })

map("n", "<leader>f", function()
  require("fff").find_files()
end, { desc = "FFFind files" })

-- map("n", "<leader>a", "<Cmd>:norm ggVGy<CR>", { desc = "Yanks Everything In The File" })
map("n", "<leader>a", "<Cmd>:norm ggVG<CR>", { desc = "Visually selects everything in the file" })

--#endregion

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
    vim.highlight.on_yank()
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
api.nvim_create_autocmd(
  "VimResized",
  { desc = "Auto resize panes when resizing nvim window", pattern = "*", command = "tabdo wincmd =" }
)

--no auto continue comments on new line
api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    if event.data.updated then
      require("fff.download").download_or_build_binary()
    end
  end,
})

-- Custom command to call Conform format
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
--#endregion

--#region Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,

  virtual_lines = {
    current_line = true,
  },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅙 ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
    },
  },
})
--#endregion

--#region Colours and Theming
vim.cmd("colorscheme " .. default_color)
--#endregion
