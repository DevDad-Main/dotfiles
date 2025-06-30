return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets = opts.presets or {}
      opts.presets.lsp_doc_border = true

      opts.popupmenu = {
        relative = "editor",
        zindex = 65,
        position = "auto", -- when auto, then it will be positioned to the cmdline or cursor
        size = {
          width = "auto",
          height = "auto",
          max_height = 20,
          max_width = 60,
          -- min_width = 10,
        },
      }
    end,
  },
}
