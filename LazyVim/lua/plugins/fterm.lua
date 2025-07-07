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

      -- Alt+i to open in current buffer’s directory
      vim.keymap.set("n", "<A-i>", function()
        fterm
          :new({
            cmd = os.getenv("SHELL"),
            cwd = vim.fn.expand("%:p:h"),
          })
          :toggle()
      end, { desc = "Toggle FTerm in current buffer dir" })
    end,
  },
}

-- return {
--   {
--     "numToStr/FTerm.nvim",
--
--     config = function()
--       local fterm = require("FTerm")
--       fterm.setup({
--         border = "double",
--         dimensions = {
--           height = 0.9,
--           width = 0.9,
--         },
--       })
--     end,
--   },
-- }
