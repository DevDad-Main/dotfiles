return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    })

    vim.cmd([[colorscheme tokyonight-night]])
  end,
}
