return {
  "mikavilpas/yazi.nvim",
  keys = { "<leader>-", "<leader>e" },
  config = function()
    require("yazi").setup({
      floating_window_scaling_factor = 1,
    })
  end,
}