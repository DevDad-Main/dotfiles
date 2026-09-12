require("vim._core.ui2").enable({})
vim.g.mapleader = " "                               -- space leader key
vim.g.maplocalleader = " "                          -- space leader key

vim.o.termguicolors = true                          -- enable 24-bit colors
vim.o.updatetime = 200                              -- save swap file with 200ms debouncing
vim.o.swapfile = false                              -- disable swapfile
vim.o.backup = false                                -- disable backup on q
vim.o.autoread = true                               -- auto update file if changed outside of nvim
vim.o.undofile = true                               -- persistant undo history
vim.o.number = true                                 -- enable line numbers
vim.o.relativenumber = true                         -- enable relative line numbers

vim.o.completeopt = "menu,menuone,noselect,preview" -- omnicomplete options for popup menu
vim.o.pumheight = 10                                -- max height of completion menu
vim.o.winborder = "rounded"                         -- rounded border
vim.o.showmode = false                              -- disable showing mode below statusline
vim.o.clipboard = "unnamedplus"                     -- share the system clipboard with the default register

vim.o.cursorline = true                             -- enable cursor line
vim.o.signcolumn = "yes"                            -- always show sign column
vim.o.ignorecase = true                             -- case-insensitive search
vim.o.smartcase = true                              -- until search pattern contains upper case characters
vim.o.incsearch = true                              -- enable highlighting search in progress

vim.o.tabstop = 2                                   -- how many spaces tab inserts
vim.o.softtabstop = 2                               -- how many spaces tab inserts
vim.o.shiftwidth = 2                                -- controls number of spaces when using >> or << commands
vim.o.expandtab = true                              -- use appropriate number of spaces with tab
vim.o.smartindent = true                            -- indenting correctly after {
vim.o.autoindent = true                             -- copy indent from current line when starting new line
vim.o.scrolloff = 8                                 -- always keep 8 lines above/below cursor unless at start/end of file

vim.o.splitbelow = true                             -- better splitting
vim.o.splitright = true                             -- better splitting

vim.o.wrap = false                                  -- disable wrapping
vim.o.breakindent = true                            -- prevent line wrapping
-- vim.opt.fillchars = { vert = " " } -- remove line divider between splits
vim.opt.fillchars = { eob = " " }
vim.o.laststatus = 3 -- global statusline

-- Folding
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.require'ufo'.foldexpr()"


-- UFO fold handler
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
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

-- Store handler globally for UFO to use
_G.ufo_fold_handler = handler
--#endregion

-- Neovide GUI settings
if vim.g.neovide then
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_normal_opacity = 0.85
end
