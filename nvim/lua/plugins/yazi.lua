return {
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  config = function()
    require("yazi").setup({
      floating_window_scaling_factor = 1,
    })
  end,
}

