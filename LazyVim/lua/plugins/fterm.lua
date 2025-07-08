return {

  {
    "numToStr/FTerm.nvim",
    config = function()
      -- First, configure FTerm
      require("FTerm").setup({
        border = "single",
        dimensions = {
          height = 0.7,
          width = 0.7,
        },
      })

      -- Then set up the keybinding using the actual module
      vim.keymap.set("n", "<A-i>", function()
        require("FTerm")
          :new({
            cmd = os.getenv("SHELL"),
            cwd = vim.fn.expand("%:p:h"),
          })
          :toggle()
      end, { desc = "Toggle FTerm in current buffer dir" })
    end,
  },
} -- return {
--   {
--     "numToStr/FTerm.nvim",
--     config = function()
--       local fterm = require("FTerm").setup({
--
--         border = "double",
--         dimensions = {
--           height = 0.7,
--           width = 0.7,
--         },
--
--         -- Alt+i to open in current buffer’s directory
--         vim.keymap.set("n", "<A-i>", function()
--           fterm
--             :new({
--               cmd = os.getenv("SHELL"),
--               cwd = vim.fn.expand("%:p:h"),
--             })
--             :toggle()
--         end, { desc = "Toggle FTerm in current buffer dir" }),
--       })
--
--       -- fterm.setup({
--       --   border = "double",
--       --   dimensions = {
--       --     height = 0.7,
--       --     width = 0.7,
--       --   },
--       -- })
--       --
--       -- -- Alt+i to open in current buffer’s directory
--       -- vim.keymap.set("n", "<A-i>", function()
--       --   fterm
--       --     :new({
--       --       cmd = os.getenv("SHELL"),
--       --       cwd = vim.fn.expand("%:p:h"),
--       --     })
--       --     :toggle()
--       -- end, { desc = "Toggle FTerm in current buffer dir" })
--     end,
--   },
-- }

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
