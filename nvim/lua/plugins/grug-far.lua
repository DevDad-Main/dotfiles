return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>Gr",
        function()
          require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
        end,
        desc = "Grug Far: search word under cursor",
      },
      {
        "<leader>Go",
        function()
          require("grug-far").open()
        end,
        desc = "Grug Far: open (custom search)",
      },
    },
    config = function()
      require("grug-far").setup({})
    end,
  },
}
