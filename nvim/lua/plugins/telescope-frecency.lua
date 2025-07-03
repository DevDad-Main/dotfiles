return {
  {
    "nvim-telescope/telescope-frecency.nvim",
    -- We need to install telescope first to actually use this plugin.
    -- If this breaks anything we can remove it
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          frecency = {
            show_scores = true,
            -- Show the path of the acitve filter before file paths
            -- So if im in my dotfiles directory it will show me that
            -- before the name of the title
            show_filter_column = false,
          },
        },
      })
      require("telescope").load_extension("frecency")
    end,
  },
}
