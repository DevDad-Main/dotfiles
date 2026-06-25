return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    { "vim-scripts/dbext.vim", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    -- Automatically execute query when selecting a table helper
    vim.g.db_ui_auto_execute_table_helpers = 1

    -- DEFINE YOUR PREFERRED COMPACT WIDTH (Default is 40)
    vim.g.db_ui_winwidth = 40

    vim.g.dadbod_sqlcmd_executable = vim.fn.expand("~") .. "/.local/bin/sqlcmd-wrapper"

    --  MOVE TO THE RIGHT AND RE-APPLY THE COMPACT WIDTH
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbui",
      callback = function()
        -- Move pane to the far right side
        vim.cmd("wincmd L")
        -- Forcefully resize it back down to your exact preference
        vim.cmd("vertical resize " .. vim.g.db_ui_winwidth)
      end,
    })
  end,
}
