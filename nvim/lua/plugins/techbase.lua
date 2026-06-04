return {
  {
    "mcauley-penney/techbase.nvim",
    opts = {
      italic_comments = false,

      -- set to true to make the background, floating windows, statusline,
      -- signcolumn, foldcolumn, and tabline transparent
      transparent = false,
      -- allows you to override any highlight group for finer-grained control
      hl_overrides = {},
    },
    config = function()
      vim.cmd.colorscheme("techbase")
    end,
  },
}
