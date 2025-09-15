local theme = {
  fill = "TabLineFill",
  head = { fg = "#75beff", bg = "#1c1e26", style = "italic" },
  current_tab = "TabLineSel",
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}

return {
  {
    "nanozuki/tabby.nvim",
    config = function()
      vim.o.showtabline = 2
      vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

      require("tabby").setup({
        line = function(line)
          return {
            {
              -- Using a neovim symbol
              { "  ", hl = theme.head },
              -- { "  ", hl = theme.head },
              line.sep("", theme.head, theme.fill),
            },
            line.tabs().foreach(function(tab)
              local hl = tab.is_current() and theme.current_tab or theme.tab
              return {
                line.sep("", hl, theme.fill),
                tab.is_current() and "" or "󰆣",
                tab.number(),
                tab.name(),
                tab.close_btn(""),
                line.sep("", hl, theme.fill),
                hl = hl,
                margin = " ",
              }
            end),
            line.spacer(),
            {
              line.sep("", theme.tail, theme.fill),
              { "  ", hl = theme.tail },
            },
            hl = theme.fill,
          }
        end,
      })
    end,
  },
}
