return {
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>p",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>f",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Telescope Find Files",
      },
      {
        "<leader>z",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Telescope live grep",
      },
      {
        "<leader>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Telescope buffers",
      },

      -- vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
      -- vim.keymap.set("n", "<leader>j", builtin.help_tags, { desc = "Telescope help tags" })
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
}
