-- pretty-ts-errors.lua
return {
  {
    "youyoumu/pretty-ts-errors.nvim",
    opts = {
      executable = "pretty-ts-errors-markdown", -- Path to the executable
      float_opts = {
        border = "rounded", -- Border style for floating windows
        max_width = 80, -- Maximum width of floating windows
        max_height = 20, -- Maximum height of floating windows
        wrap = true, -- Whether to wrap long lines
      },
      auto_open = false, -- Automatically show errors on hover
      lazy_window = false, -- Open the floating window only after errors are formatted
    },
  },
}
