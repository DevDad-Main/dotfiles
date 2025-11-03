local M = {}

M.base_30 = {
  white = "#F3EDE7", -- warm off-white
  darker_black = "#2C2A27",
  black = "#2F2C29", -- main bg (brighter)
  black2 = "#383530",

  one_bg = "#3C3833",
  one_bg2 = "#45403A",
  one_bg3 = "#4D4842",

  grey = "#7C756E",
  grey_fg = "#8B847D",
  grey_fg2 = "#948E87",
  light_grey = "#5F5953",

  red = "#D98A7A", -- warm clay red
  orange = "#E19A61", -- richer orange accent
  yellow = "#EED49F", -- pastel sand yellow
  sun = "#F3DCA6", -- soft light yellow

  green = "#B3CDA7", -- mild leaf green
  vibrant_green = "#A9C39C",

  blue = "#9CBBD0", -- calm sky blue
  nord_blue = "#8BAEC3",

  cyan = "#96C4C0", -- sea-foam teal
  teal = "#9AC3A8",

  purple = "#C3ADD2", -- lavender tint
  dark_purple = "#AB95B9",

  line = "#3B3733", -- for splits
  statusline_bg = "#35322E",
  lightbg = "#3D3935",
  pmenu_bg = "#A9C39C",
  folder_bg = "#9CBBD0",
}

M.base_16 = {
  base00 = "#2F2C29",
  base01 = "#383530",
  base02 = "#3C3833",
  base03 = "#45403A",
  base04 = "#4C4741",
  base05 = "#E2DAD3",
  base06 = "#ECE5DF",
  base07 = "#F3EDE7",

  base08 = "#D98A7A",
  base09 = "#E19A61",
  base0A = "#EED49F",
  base0B = "#B3CDA7",
  base0C = "#96C4C0",
  base0D = "#9CBBD0",
  base0E = "#C3ADD2",
  base0F = "#D98A7A",
}

M.polish_hl = {
  treesitter = {
    ["@variable"] = { fg = M.base_30.white },
    ["@variable.parameter"] = { fg = M.base_30.white },
    ["@variable.builtin"] = { fg = M.base_30.red },

    ["@function.builtin"] = { fg = M.base_30.cyan },
    ["Function"] = { fg = M.base_30.blue },

    ["@function"] = { fg = M.base_30.blue },
    ["@keyword"] = { fg = M.base_30.purple },

    ["@property"] = { fg = M.base_30.cyan },
    ["@type.builtin"] = { fg = M.base_30.purple },
  },
}

M.type = "dark"

return M
