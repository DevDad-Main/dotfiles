return {
  "vague2k/vague.nvim",
  lazy = false,
  priority = 900,
  enabled = false,
  config = function()
    require("vague").setup({ transparent = true })
    vim.cmd("colorscheme vague")
  end,
}
