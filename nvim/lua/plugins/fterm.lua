return {
  {
    "numToStr/FTerm.nvim",

    config = function()
      local fterm = require("FTerm")
      fterm.setup({
        border = "double",
        dimensions = {
          height = 0.9,
          width = 0.9,
        },
      })
    end,
  },
}
