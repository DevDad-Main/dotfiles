return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "VeryLazy" },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "typescript", "tsx", "javascript", "lua", "json", "prisma" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}