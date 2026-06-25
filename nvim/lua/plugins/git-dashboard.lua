-- NOTE: Used to show the branch nerd icon on the dahsboard
vim.g.have_nerd_font = true

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    { "juansalvatore/git-dashboard-nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  opts = function()
    local git_dashboard = require("git-dashboard-nvim").setup({
      show_only_weeks_with_commits = true,
      -- colors = {
      --   days_and_months_labels = "Function",
      --   empty_square_highlight = "Comment",
      --   filled_square_highlights = {
      --     "Function",
      --     "Function",
      --     "Function",
      --     "Function",
      --     "Function",
      --     "Function",
      --   },
      --   branch_highlight = "Function",
      --   dashboard_title = "Function",
      -- },
    })

    local opts = {
      theme = "doom",
      config = {
        header = git_dashboard,
        center = {
          { action = "", desc = "", icon = "", key = "n" },
        },
        footer = function()
          return {}
        end,
      },
    }

    -- extra dashboard nvim config ...

    return opts
  end,
}
