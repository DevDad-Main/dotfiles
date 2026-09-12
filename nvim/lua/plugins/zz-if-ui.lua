-- if.nvim UI/theme, ported into this config.
--
-- Pulls in only the theme engine + statusline + dashboard from
-- if-then-nvim/if.nvim (the "nvim.bak" starter), without adopting its whole
-- distribution (no plugin imports, options, or mappings replaced).
--
-- To revert: remove this file, restore lua/ui/init.lua, and remove the
-- "if.nvim" entry from lazy-lock.json.
--
-- Theme is re-applied on every `ColorScheme` event so it wins over the other
-- colorscheme plugins in this config.
--
-- Docs / defaults: https://github.com/if-then-nvim/if.nvim (lua/if/defaults.lua)

local dashboard_actions = {
  find = "find_files()",
  grep = "live_grep()",
  recent = "oldfiles()",
  marks = "marks()",
  config = "find_files({ cwd = vim.fn.stdpath('config') })",
  git = "git_status()",
  keys = "keymaps()",
}

local dashboard = {
  components = {
    -- same two-tone logo as the online config
    header = { color = "neovim" },
  },
}
for name, call in pairs(dashboard_actions) do
  dashboard.components[name] = { action = "lua require('telescope.builtin')." .. call }
end

return {
  "if-then-nvim/if.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- if.nvim reads vim.g.if_opts when its config is required.
    vim.g.if_opts = {
      theme = {
        palette = "if-dark",
        transparent = true,
      },
      statusline = {
        order = {
          "filetype",
          "lsp",
          "git_branch",
          "git_diff",
          "spacer",
          "lsp_progress",
          "spacer",
          "diagnostics",
          "cwd",
          "cursor",
        },
      },
      dashboard = dashboard,
    }

    -- Theme: compile (cached bytecode) and apply.
    require("if.theme.cache").setup()

    -- Keep the if theme on top whenever a colorscheme change happens.
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("if_nvim_theme", { clear = true }),
      callback = function()
        require("if.theme").setup()
      end,
    })

    -- UI: statusline (replaces lua/ui/statusline.lua) + dashboard.
    require("if.ui.statusline").setup()
    require("if.ui.dashboard").setup()
  end,
}