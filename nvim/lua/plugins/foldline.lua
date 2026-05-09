-- init.lua:
return {
  "gh-liu/fold_line.nvim",
  event = "VeryLazy",
  init = function()
    -- change the char of the line, see the `Appearance` section
    vim.g.fold_line_char_top_close = "+" -- default: fillchars.foldclose or "+"
    vim.g.fold_line_char_close = "├" -- default: fillchars.vertright or "├"
    vim.g.fold_line_char_open_sep = "│" -- default: fillchars.foldsep or "│"
    vim.g.fold_line_char_open_start = "╭" -- default: "┌"
    vim.g.fold_line_char_open_end = "╰" -- default: "└"
    vim.g.fold_line_char_open_start_close = "╒" -- default: "╒"
    vim.g.fold_line_char_open_end_close = "╘" -- default: "╘"

    vim.g.fold_line_current_fold_only = true
  end,
}
