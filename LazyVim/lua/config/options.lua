-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

-- vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.spelllang = "en_gb"
vim.o.hidden = true
-- vim.opt.spell = true

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- ############################################################################
--                             Neovide section
-- ############################################################################

-- NOTE: When in LazyGit if inside or outside neovim, if you want to edit files with
-- Neovide, you have to set the os.edit option in the
-- ~/github/dotfiles-latest/lazygit/config.yml file

-- NOTE: Also remember that there are settings in the file:
-- ~/github/dotfiles-latest/neovide/config.toml

-- NOTE: Text looks a bit bolder in Neovide, it doesn't bother me, but I think
-- there's no way to fix it, see:
-- https://github.com/neovide/neovide/issues/1231

-- The copy and paste sections were found on:
-- https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste
if vim.g.neovide then
  vim.o.cmdheight = 0
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

  -- This allows me to use cmd+v to paste stuff into neovide
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

  -- Specify the font used by Neovide
  -- vim.o.guifont = "MesloLGM_Nerd_Font:h14"
  vim.o.guifont = "JetBrainsMono Nerd Font:h15"
  -- vim.o.guifont = "FiraCode Nerd Font:h15"
  -- This is limited by the refresh rate of your physical hardware, but can be
  -- lowered to increase battery life
  -- This setting is only effective when not using vsync,
  -- for example by passing --no-vsync on the commandline.
  --
  -- NOTE: vsync is configured in the neovide/config.toml file, I disabled it and set
  -- this to 120 even though my monitor is 75Hz, had a similar case in wezterm,
  -- see: https://github.com/wez/wezterm/issues/6334
  vim.g.neovide_refresh_rate = 120
  -- This is how fast the cursor animation "moves", the higher the number, the
  -- more you will see the trail when jumping to end of line
  -- default 0.150
  vim.g.neovide_cursor_animation_length = 0.18
  -- Time it takes for the cursor to complete its animation in seconds for short
  -- horizontal travels of one or two characters, like when typing.
  -- Default 0.04
  vim.g.neovide_cursor_short_animation_length = 0.15
  -- Time it takes for a window to complete animation from one position to another
  -- position in seconds, such as :split.
  -- Default 0.15
  vim.g.neovide_position_animation_length = 0.20
  -- changes how much the back of the cursor trails the front. Set to 1.0 to
  -- make the front jump to the destination immediately with a maximum trail size.
  -- A lower value makes a smoother animation, with a shorter trail, but also adds lag
  -- Default 0.7
  vim.g.neovide_cursor_trail_size = 7

  -- Really weird issue in which my winbar would be drawn multiple times as I
  -- scrolled down the file, this fixed it, found in:
  -- https://github.com/neovide/neovide/issues/1550
  -- Default 0.3
  vim.g.neovide_scroll_animation_length = 0

  -- produce particles behind the cursor, if want to disable them, set it to ""
  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  -- vim.g.neovide_cursor_vfx_mode = "torpedo"
  -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  -- vim.g.neovide_cursor_vfx_mode = ""
  -- vim.g.neovide_cursor_vfx_mode = "ripple"
  -- vim.g.neovide_cursor_vfx_mode = "wireframe"
  --
  --
  -- This allows me to use the right "alt" key in macOS, because I have some
  -- neovim keymaps that use alt, like alt+t for the terminal
  -- https://youtu.be/33gQ9p-Zp0I
  -- vim.g.neovide_input_macos_option_key_is_meta = "only_right"
end

-- I also want the vim.g.neovim_mode cursor color to be changed
-- Neovide cursor color, remember to set these in your colorscheme, I have
-- mine set in ~/github/dotfiles-latest/neovim/neobean/lua/plugins/colorschemes/eldritch.lua
-- Otherwise, my cursor was white
vim.opt.guicursor = {
  "n-v-c-sm:block-Cursor", -- Use 'Cursor' highlight for normal, visual, and command modes
  "i-ci-ve:ver25-lCursor", -- Use 'lCursor' highlight for insert and visual-exclusive modes
  "r-cr:hor20-CursorIM", -- Use 'CursorIM' for replace mode
}

-- ############################################################################
--                           End of Neovide section
-- ############################################################################
