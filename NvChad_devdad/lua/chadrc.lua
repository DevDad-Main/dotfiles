---@class ChadrcConfig
local M = {}

local core = require "custom.utils.core"

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"
M.ui = {
  -- statusline = core.statusline,
  -- tabufline = core.tabufline,

  statusline = {
    theme = "minimal",
    separator_style = "round",
    -- order = { "mode", "f", "git", "%=", "lsp_msg", "%=", "lsp", "cwd", "xyz", "abc" },
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    format_colors = {
      lsp = true,
      icon = "󱓻",
    },
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

  telescope = { style = "bordered" },

  transparency = true,
}

M.nvdash = core.nvdash

M.lsp = { signature = false }

M.mason = {
  pkgs = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettierd",
    "eslint-lsp",
    "eslint_d",
    "emmet-ls",
    "rustywind",

    -- Spell
    "marksman",

    -- Json
    "jsonlint",
    "json-lsp",

    "dockerfile-language-server",
    "hadolint",
    "docker-compose-language-service",

    -- golang
    "gopls",
    "goimports",
    "golines",
    "gomodifytags",
    "impl",
    "iferr",
    "go-debug-adapter",
  },
}

M.base46 = {
  integrations = {
    "blankline",
    "cmp",
    "defaults",
    "devicons",
    "edgy",
    "grug_far",
    "git",
    "lsp",
    "markview",
    "mason",
    "nvcheatsheet",
    "nvimtree",
    "statusline",
    "syntax",
    "tbline",
    "telescope",
    "whichkey",
    "dap",
    "hop",
    "treesitter",
    "rainbowdelimiters",
    "diffview",
    "todo",
    "trouble",
    "notify",
  },

  theme = "nord", ---@diagnostic disable-line
  theme_toggle = { "nord", "one_light" }, ---@diagnostic disable-line

  -- NOTE: Remove this if you don't want transparency for statusline, tabbuf and nvimtree
  -- FIXME: Messes with the yank highlights
  -- transparency = true,

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.term = {
  winopts = {
    winfixbuf = true,
    number = false,
    relativenumber = false,
  },
  -- INFO: Change the height and width of the splits/vsplit via these sizes 1 = 100%, 0.9 = 90%, 0.8 = 80%, etc.
  sizes = { sp = 0.4, vsp = 0.2, ["bo sp"] = 0.4, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.1,
    col = 0.1,
    -- width = 0.5,
    -- height = 0.4,
    width = 0.8,
    height = 0.8,
    border = "single",
  },
}

M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",

  highlight = {
    hex = true,
    lspvars = true,
  },
}

M.lazy_nvim = core.lazy

M.gitsigns = {
  signs = {
    add = { text = " " },
    change = { text = " " },
    delete = { text = " " },
    topdelete = { text = " " },
    changedelete = { text = " " },
    untracked = { text = " " },
  },
}

M.plugins = "custom.plugins"

-- TODO: Temporary fix for NvChad Mapping changes (I dont wanna edit all my mappings)
M.mappings = require "custom.old_mappings"
core.load_mappings "folder"
core.load_mappings "comment"
core.load_mappings "development"
core.load_mappings "text"
core.load_mappings "window"
core.load_mappings "general"
core.load_mappings "diagnostics"
core.load_mappings "debug"
core.load_mappings "git"
core.load_mappings "telescope"
core.load_mappings "tabufline"
core.load_mappings "searchbox"
core.load_mappings "nvterm"
core.load_mappings "lspconfig"

return M
