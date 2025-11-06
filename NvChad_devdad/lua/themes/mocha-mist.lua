local M = {}
M.base_30 = {
  white = "#F0E8E0",
  darker_black = "#3A3530", -- ↑
  black = "#3D3833", -- main bg – now much lighter
  black2 = "#46413C",
  one_bg = "#4A453F",
  one_bg2 = "#534E47",
  one_bg3 = "#5C564F",
  grey = "#7F766C",
  grey_fg = "#8E857A",
  grey_fg2 = "#9A9185",
  light_grey = "#6A635A",
  red = "#D87D6B",
  orange = "#E89A5A",
  yellow = "#EBD69C",
  sun = "#F0DDAA",
  green = "#AFC89C",
  vibrant_green = "#A3BF94",
  blue = "#97B8CE",
  nord_blue = "#87A9C0",
  cyan = "#92C0BC",
  teal = "#96BFA3",
  purple = "#BEABD0",
  dark_purple = "#A893B7",
  line = "#49443E", -- split lines
  statusline_bg = "#433E38",
  lightbg = "#4D4741",
  pmenu_bg = "#A3BF94",
  folder_bg = "#97B8CE",
}

M.base_16 = {
  base00 = "#3D3833", -- main bg
  base01 = "#46413C",
  base02 = "#4A453F",
  base03 = "#534E47",
  base04 = "#5C564F",
  base05 = "#E0D8D0",
  base06 = "#EBE4DD",
  base07 = "#F0E8E0",
  base08 = "#D87D6B",
  base09 = "#E89A5A",
  base0A = "#EBD69C",
  base0B = "#AFC89C",
  base0C = "#92C0BC",
  base0D = "#97B8CE",
  base0E = "#BEABD0",
  base0F = "#D87D6B",
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
