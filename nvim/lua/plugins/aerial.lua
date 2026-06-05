return {
  "mcauley-penney/aerial.nvim",
  version = "fix-md-header-icons",
  config = function()
    require("aerial").setup({
      close_automatic_events = {
        "unfocus",
        "switch_buffer",
      },
      show_guides = false,
      guides = {
        nested_top = " │ ",
        mid_item = " ├─",
        last_item = " └─",
        whitespace = "    ",
      },
      layout = {
        placement = "window",
        close_on_select = false,
        max_width = 45,
        min_width = 25,
      },
      ignore = {
        buftypes = {},
      },
      icons = tools.ui.kind_icons,
      open_automatic = function()
        local aerial = require("aerial")
        return vim.api.nvim_win_get_width(0) > 80 and not aerial.was_closed()
      end,
    })
    vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle<cr>", { silent = true })
  end,
}
