-- local opt = vim.opt
-- local g = vim.g
-- local opts = {}
--
-- opts.initial = function()
--   opt.laststatus = 3
--   opt.clipboard = "unnamedplus"
--   opt.termguicolors = true
--   opt.fillchars:append { eob = " " }
--   opt.shortmess:append "aIF"
--   opt.cursorline = true
--   opt.cursorlineopt = "number"
--   opt.ruler = true
--   opt.number = true
--   opt.relativenumber = true
--   opt.breakindent = true
--   opt.linebreak = true
--   opt.swapfile = false
--   opt.undofile = true
--   opt.cmdheight = 0
--   opt.winborder = "rounded"
--
--   g.border_style = "rounded" ---@type "single"|"double"|"rounded"
--   g.winblend = 0
--   g.mapleader = " "
--
--   -- Disable providers
--   g.loaded_node_provider = 0
--   g.loaded_python3_provider = 0
--   g.loaded_perl_provider = 0
--   g.loaded_ruby_provider = 0
-- end
--
-- opts.final = function()
--   opt.completeopt = { "menuone", "noselect", "noinsert" }
--   opt.wildmenu = true
--   opt.pumheight = 10
--   opt.ignorecase = true
--   opt.smartcase = true
--   opt.timeout = false
--   opt.updatetime = 400
--   opt.confirm = false
--   opt.equalalways = false
--   opt.splitbelow = true
--   opt.splitright = true
--   opt.scrolloff = 2
--
--   -- Indenting
--   opt.shiftwidth = 2
--   opt.smartindent = true
--   opt.tabstop = 2
--   opt.expandtab = true
--   opt.softtabstop = 2
--   opt.sidescrolloff = 2
--
--   -- Statusline
--   local statusline_ascii = ""
--   opt.statusline = "%#Normal#" .. statusline_ascii .. "%="
-- end
--
-- vim.g.neovide_padding_top = 25
-- vim.g.neovide_padding_bottom = 25
-- vim.g.neovide_padding_right = 25
-- vim.g.neovide_padding_left = 25
--
-- --- Load shada after ui-enter
-- local shada = vim.o.shada
-- vim.o.shada = ""
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "VeryLazy",
--   callback = function()
--     vim.o.shada = shada
--     pcall(vim.cmd.rshada, { bang = true })
--   end,
-- })
--
-- vim.diagnostic.config {
--   virtual_text = {
--     prefix = "",
--     suffix = "",
--     format = function(diagnostic)
--       return " " .. diagnostic.message .. " "
--     end,
--   },
--   underline = {
--     severity = { min = vim.diagnostic.severity.WARN },
--   },
--   signs = {
--     text = {
--       [vim.diagnostic.severity.HINT] = "",
--       [vim.diagnostic.severity.ERROR] = "✘",
--       [vim.diagnostic.severity.INFO] = "◉",
--       [vim.diagnostic.severity.WARN] = "󰚌",
--     },
--   },
-- }
--
-- return opts
--
require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local indent = 4
local opt = vim.opt -- to set options
local g = vim.g

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
opt.backspace = { "indent", "eol", "start" }
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"

opt.cursorline = false
opt.cursorcolumn = false

opt.encoding = "utf-8" -- Set default encoding to UTF-8
-- opt.foldenable = true
--
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = "manual"

-- opt.formatoptions = "l"
opt.hidden = true -- Enable background buffers
opt.hlsearch = true -- Highlight found searches
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- Get a preview of replacements
opt.incsearch = true -- Shows the match while typing
opt.joinspaces = false -- No double spaces with join
vim.o.lazyredraw = true
opt.linebreak = true -- Stop words being broken on wrap
opt.number = true -- Show line numbers
opt.listchars = { tab = " ", trail = "·", nbsp = "%" }
-- opt.listchars = {
--   tab = '❘-',
--   trail = '·',
--   lead = '·',
--   extends = '»',
--   precedes = '«',
--   nbsp = '×',
-- }
opt.list = true -- Show some invisible characters
opt.relativenumber = true
vim.o.shortmess = vim.o.shortmess .. "S" -- stops display of currentsearch match in cmdline area
opt.equalalways = true -- make windows the same width when closing one
opt.cursorlineopt = "both" -- should get cursorline in number too

-- opt.expandtab = true
-- opt.shiftwidth = indent
-- opt.softtabstop = indent
-- opt.tabstop = indent

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.showmode = false -- Don't display mode
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes:1" -- always show signcolumns
opt.smartcase = true -- Do not ignore case with capitals
opt.spelllang = { "en_gb" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
-- opt.splitkeep = "screen" -- Stops screen jumping when splits below are opened
opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4000.
opt.title = true -- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'
-- Give me some fenced codeblock goodness
vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }
vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
opt.wrap = true
-- opt.cc = "80"
opt.mouse = "a"
opt.guicursor =
  "n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"
opt.undodir = vim.fn.stdpath "config" .. "/undo"
opt.undofile = true
-- vim.notify = require("notify")
opt.jumpoptions = "view"
opt.timeoutlen = 300 -- The time before a key sequence should complete
opt.cpoptions:append ">" -- when you yank multiple times into a register, this puts each on a new line
opt.nrformats:append "alpha" -- this means you can increment lists that have letters with `g ctrl-a`
-- opt.pumblend = 5 -- partial opacity of pop up menu, this causes characters in lspkind to render incorrect width and means that you have to set up kitty to use narrow symbols. See https://github.com/kovidgoyal/kitty/discussions/7774#discussioncomment-10442608
opt.ph = 15 -- the number is the number of entries to show before scrollbars, not px!
opt.cmdheight = 0
opt.virtualedit = "block" -- allows using visual blocks beyond the end of a line
vim.g.editorconfig = false -- disable editor config as VSCode does not have it on by default

--- use Neovim nightly branch
-- opt.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"

local api = vim.api
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

-- This is global settings for diagnostics
vim.o.updatetime = 250

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
    suffix = "",
    format = function(diagnostic)
      return " " .. diagnostic.message .. " "
    end,
  },
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.INFO] = "◉",
      [vim.diagnostic.severity.WARN] = "󰚌",
    },
  },
}
-- vim.diagnostic.config {
--   virtual_text = false,
--   signs = true,
--   underline = true,
--   update_in_insert = false,
--   severity_sort = false,
--
--   --NOTE: Comment this out to disable inline virtual diagnostics
--   virtual_lines = {
--     current_line = true,
--   },
--
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = "󰅙 ",
--       [vim.diagnostic.severity.WARN] = " ",
--       [vim.diagnostic.severity.HINT] = "󰌵",
--       [vim.diagnostic.severity.INFO] = "󰋼 ",
--       -- [vim.diagnostic.severity.ERROR] = "󰅚 ",
--       -- [vim.diagnostic.severity.WARN] = "󰳦 ",
--       -- [vim.diagnostic.severity.HINT] = "󱡄 ",
--       -- [vim.diagnostic.severity.INFO] = " ",
--     },
--   },
-- }

if g.neovide then
  -- #region Old Neovide
  opt.guifont = "VictorMono Nerd Font:h10"
  -- opt.guifont = "JetbrainsMono Nerd Font:h9"
  -- opt.guifont = "JetbrainsMono Nerd Font:h12"
  g.neovide_refresh_rate = 120
  g.neovide_remember_window_size = true
  g.neovide_cursor_antialiasing = true
  g.neovide_input_macos_option_key_is_meta = "both"
  g.neovide_input_use_logo = false
  g.neovide_padding_top = 0
  g.neovide_padding_bottom = 0
  g.neovide_padding_right = 0
  g.neovide_padding_left = 0
  g.neovide_floating_blur_amount_x = 0.0
  g.neovide_floating_blur_amount_y = 0.0
  g.neovide_floating_shadow = false
  g.neovide_floating_z_height = 40
  g.neovide_light_angle_degrees = 45
  g.neovide_light_radius = 10
  g.neovide_scroll_animation_length = 0.5
  g.neovide_scroll_animation_far_lines = 1
  g.neovide_hide_mouse_when_typing = true
  g.neovide_underline_automatic_scaling = true
  g.neovide_floating_corner_radius = 10.0
  g.neovide_cursor_vfx_mode = "pixiedust"

  -- vim.g.neovide_floating_shadow = true
  -- vim.g.neovide_floating_z_height = 10
  -- vim.g.neovide_light_angle_degrees = 45
  -- vim.g.neovide_light_radius = 5

  -- g.neovide_increment_scale_factor = 0.1
  -- g.neovide_scale_factor = 1
  -- g.neovide_scale_factor = 1
  -- g.neovide_max_scale_factor = 2.0
  -- g.neovide_min_scale_factor = 0.7

  -- See https://github.com/neovide/neovide/issues/2330
  vim.schedule(function()
    vim.cmd "NeovideFocus"
  end)

  -- https://github.com/neovide/neovide/issues/1771
  vim.api.nvim_create_autocmd({ "BufLeave", "BufNew" }, {
    callback = function()
      vim.g.neovide_scroll_animation_length = 0
      vim.g.neovide_cursor_animation_length = 0
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
    callback = function()
      vim.fn.timer_start(32, function()
        vim.g.neovide_scroll_animation_length = 0.3
        vim.g.neovide_cursor_animation_length = 0.08
      end)
    end,
  })
end
-- #endregion
