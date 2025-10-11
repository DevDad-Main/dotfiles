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
}
