return {
  {
    'folke/noice.nvim',
    opts = function(_, opts)
      opts.presets = opts.presets or {}
      opts.presets.lsp_doc_border = true

      opts.presets = {
        command_palette = true,
        lsp_doc_border = false, -- add a border to hover docs and signature help
      }
      opts.popupmenu = {
        relative = 'editor',
        zindex = 65,
        position = 'top', -- when auto, then it will be positioned to the cmdline or cursor
        size = {
          width = 'auto',
          height = 'auto',
          max_height = 20,
          max_width = 60,
          -- min_width = 10,
        },
        -- LSP progress & messages
        -- opts.lsp = {
        --   progress = {
        --     enabled = true,
        --   },
        --   hover = {
        --     enabled = true,
        --   },
        --   signature = {
        --     enabled = true,
        --   },
        --   message = {
        --     enabled = true,
        --   },
      }
    end,
  },
}
