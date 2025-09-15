local theme = {
  fill = "TabLineFill",
  head = "TabLine",
  current_tab = "TabLineSel",
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}

return {
  {
    "nanozuki/tabby.nvim",
    config = function()
      -- always show tabline and keep buffers listed
      vim.o.showtabline = 2
      vim.o.hidden = true

      require("tabby").setup({
        line = function(line)
          return {
            {
              { "  ", hl = theme.head },
              line.sep("", theme.head, theme.fill),
            },

            -- <-- use line.bufs(), not line.buffers()
            line
              .bufs()
              .filter(function(buf)
                -- filter: only listed, named, normal buffers
                local ok, buflisted = pcall(vim.api.nvim_buf_get_option, buf.id, "buflisted")
                if not ok or not buflisted then
                  return false
                end
                local name = buf.name()
                if not name or name == "" or name == "[No Name]" then
                  return false
                end
                if buf.type() ~= "" then
                  return false
                end -- skip term/special buftypes
                return true
              end)
              .foreach(function(buf)
                local hl = buf.is_current() and theme.current_tab or theme.tab
                return {
                  line.sep("", hl, theme.fill),
                  buf.file_icon(), -- icon (needs web-devicons)
                  buf.is_current() and "" or "󰆣", -- indicator for current
                  { buf.name(), hl = hl }, -- buffer name
                  buf.is_changed() and " ●" or "", -- small modified marker
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

      -- NOTE: if your Tabby version complains or the API differs, try:
      -- require('tabby.tabline').set(function(line) ... end)
      -- (recent README mentions this alternative API). :contentReference[oaicite:3]{index=3}
    end,
  },
}
