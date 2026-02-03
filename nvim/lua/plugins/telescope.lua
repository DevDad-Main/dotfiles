return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "LinArcX/telescope-env.nvim",
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        preview = { treesitter = false },
        color_devicons = true,
        sorting_strategy = "ascending",
        borderchars = {
          "", "", "", "", "", "", "", "",
        },
        path_displays = { "smart" },
        layout_config = {
          height = 100,
          width = 400,
          prompt_position = "top",
          preview_cutoff = 40,
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
            ["<Esc>"] = actions.close,
            ["<C-x>"] = actions.delete_buffer,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
            ["dd"] = actions.delete_buffer,
          },
        },
      },
      pickers = {
        buffers = {
          sort_lastused = true,
          ignore_current_buffer = false,
        },
      },
    })

    telescope.load_extension("ui-select")
  end,
}