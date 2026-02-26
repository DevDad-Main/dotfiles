--#region Options
vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])
vim.cmd([[hi @lsp.type.number gui=italic]])

vim.g.netrw_liststyle = 3 -- Tree like structure
vim.g.netrw_banner = 0 -- Remove help message

-- Old Code. Allows for Gutters to be shown
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.o.foldcolumn = "1"
vim.opt.relativenumber = true

-- New Test Code - Hides Gutters
-- vim.opt.number = false -- no line numbers
-- vim.opt.relativenumber = false

vim.opt.signcolumn = "auto" -- only show when git signs exist
vim.o.foldcolumn = "0" -- no reserved fold gutter

vim.opt.winborder = "single"
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 1
vim.opt.wrap = true
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.autoindent = true -- keep previous indent
vim.opt.smartindent = true -- basic C-style indent
vim.opt.cindent = true -- MUCH smarter {} indentation
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.laststatus = 0 -- Hides Status line as we don't use it tbh

-- Enable ufo folds
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
