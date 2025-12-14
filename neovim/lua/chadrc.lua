-- NvChad UI Configuration
-- This file is required by NvChad/ui plugin
-- Table structure must be same as https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

local M = {}

-- Base46 theme configuration
M.base46 = {
  theme = "onedark", -- your theme
  theme_toggle = { "onedark", "catppuccin" },

  -- Overriding highlights
  hl_override = {
    -- Add your highlight overrides here
  },

  -- Adding custom highlights
  hl_add = {
    -- Add your custom highlights here
  },

  -- Transparency
  transparency = false,
}

-- UI configuration
M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
  },

  tabline = {
    enabled = false,
    show_numbers = false,
    show_filename_only = true,
  },

  nvdash = {
    load_on_startup = true,
  },

  cheatsheet = {
    theme = "grid",
  },

  -- Extend highlights
  hl_override = {
    -- Add your highlight overrides here
  },

  -- Add custom highlights
  hl_add = {
    -- Add your custom highlights here
  },
}

return M
