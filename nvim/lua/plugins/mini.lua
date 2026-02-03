return {
  "nvim-mini/mini.nvim",
  event = "BufReadPost",
  config = function()
    require("mini.surround").setup()
    -- require("mini.statusline").setup()
  end,
}

