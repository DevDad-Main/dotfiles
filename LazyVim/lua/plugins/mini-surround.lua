return {
  "nvim-mini/mini.surround",
  event = "VeryLazy",
  config = function()
    require("mini.surround").setup({
      -- Use 'gs' instead of 's' to avoid conflict with Flash
      mappings = {
        add = "gs", -- Add surrounding in normal/visual mode
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
        find = "", -- Disable to avoid conflict
        highlight = "", -- Disable to avoid conflict
        update_n_lines = "", -- Disable to avoid conflict
      },
    })
  end,
}
