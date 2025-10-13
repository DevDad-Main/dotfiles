local UserDecorator = require "nvim-tree.renderer.decorator.user"

---@class (exact) HighlightedString
---@field str string
---@field hl string[]

---@class (exact) UserDecoratorExample: UserDecorator
---@field private my_icon HighlightedString
local UserDecoratorExample = UserDecorator:extend()

function UserDecoratorExample:new()
  UserDecoratorExample.super.new(self, {
    enabled = true,
    hl_pos = "name",
    icon_placement = "right_align",
  })
  self.my_icon = { str = "E", hl = { "ExampleIcon" } }
end

---@param node Node
---@return HighlightedString[]|nil
function UserDecoratorExample:calculate_icons(node)
  if node.name == "example" then
    return { self.my_icon }
  end
  return nil
end

---@param node Node
---@return string|nil
function UserDecoratorExample:calculate_highlight(node)
  if node.name == "example" then
    return "ExampleHighlight"
  end
  return nil
end

-- =========================
-- Main on_attach
-- =========================
local function on_attach(bufnr)
  local api = require "nvim-tree.api"
  local lib = require "nvim-tree.lib"

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  local function smart_close_q()
    if #vim.fn.tabpagebuflist() == 1 then
      vim.cmd.quit { mods = { confirm = true } }
    end
    api.tree.close()
  end

  local function smart_close_esc()
    if #vim.fn.tabpagebuflist() == 1 then
      return
    end
    api.tree.close()
  end

  local map = vim.keymap.set

  -- 🎹 Default mappings
  map("n", "<C-]>", api.tree.change_root_to_node, opts "CD")
  map("n", "<C-e>", api.node.open.replace_tree_buffer, opts "Open: In Place")
  map("n", "<C-k>", api.node.show_info_popup, opts "Info")
  map("n", "<C-r>", api.fs.rename_sub, opts "Rename: Omit Filename")
  map("n", "<C-t>", api.node.open.tab, opts "Open: New Tab")
  map("n", "<C-v>", api.node.open.vertical, opts "Open: Vertical Split")
  map("n", "<C-x>", api.node.open.horizontal, opts "Open: Horizontal Split")
  map("n", "<BS>", api.node.navigate.parent_close, opts "Close Directory")
  map("n", "<CR>", api.node.open.edit, opts "Open")
  map("n", "<Tab>", api.node.open.preview, opts "Open Preview")
  map("n", ">", api.node.navigate.sibling.next, opts "Next Sibling")
  map("n", "<", api.node.navigate.sibling.prev, opts "Previous Sibling")
  map("n", "-", api.tree.change_root_to_parent, opts "Up")
  map("n", "a", api.fs.create, opts "Create")
  map("n", "d", api.fs.remove, opts "Delete")
  map("n", "r", api.fs.rename, opts "Rename")
  map("n", "x", api.fs.cut, opts "Cut")
  map("n", "yy", api.fs.copy.node, opts "Copy Node")
  map("n", "p", api.fs.paste, opts "Paste")
  map("n", "q", smart_close_q, opts "Close")
  map("n", "<Esc>", smart_close_esc, opts "Close")
  map("n", "R", api.tree.reload, opts "Refresh")

  -- Yazi-style navigation
  map("n", "l", function()
    local api = require "nvim-tree.api"
    local node = api.tree.get_node_under_cursor()
    if node and node.type == "directory" then
      if not node.open then
        api.node.open.edit()
      else
        api.tree.change_root_to_node(node)
      end
    else
      api.node.open.edit()
    end
  end, opts "Open or Enter Folder")

  map("n", "h", function()
    local api = require "nvim-tree.api"
    local node = api.tree.get_node_under_cursor()
    if node and node.open then
      api.node.navigate.parent_close()
    else
      api.tree.change_root_to_parent()
    end
  end, opts "Close Folder / Go Up")

end

-- =========================
-- 🎨 Gruvbox Highlights
-- =========================
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#504945", bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#d79921" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#fabd2f", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#fe8019" })
vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#b8bb26" })
vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#fb4934" })
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#665c54" })

-- =========================
-- 🔧 Setup
-- =========================
return {
  on_attach = on_attach,
  filters = {
    dotfiles = false,
    custom = { "**/node_modules", "**/%.git", "**/%.github" },
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  hijack_unnamed_buffer_when_opening = true,
  hijack_cursor = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 50,
    show_on_open_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 35,
    float = {
      enable = true,
      open_win_config = function()
        local columns = vim.o.columns
        local lines = vim.o.lines
        local width = math.floor(columns * 0.4)
        local height = math.floor(lines * 0.7)
        local row = math.floor((lines - height) / 2)
        local col = math.floor((columns - width) / 2)
        return {
          relative = "editor",
          border = "rounded",
          width = width,
          height = height,
          row = row,
          col = col,
        }
      end,
    },
  },
  sync_root_with_cwd = true,
  renderer = {
    highlight_opened_files = "name",
    highlight_git = true,
    highlight_diagnostics = true,
    group_empty = true,
    indent_markers = {
      enable = true,
      icons = { corner = "╰", edge = "│", none = "  " },
    },
    icons = {
      git_placement = "after",
      diagnostics_placement = "after",
      padding = " ",
      show = {
        git = true,
        bookmarks = false,
        diagnostics = true,
        file = true,
        folder = true,
        folder_arrow = true,
        modified = true,
      },
      glyphs = {
        default = "󰈚",
        symlink = "",
        modified = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "",
          staged = "󰄬",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  actions = {
    open_file = { quit_on_open = true, resize_window = false },
  },
  tab = { sync = { open = true, close = true } },
}
