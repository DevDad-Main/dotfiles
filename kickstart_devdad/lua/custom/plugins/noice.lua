-- return {
--   {
--     'folke/noice.nvim',
--     event = 'VeryLazy',
--     opts = function(_, opts)
--       opts.presets = opts.presets or {}
--       opts.presets.lsp_doc_border = true -- adds a border to LSP hover/signature help
--
--       opts.presets = {
--         command_palette = true,
--       }
--
--       -- Popup menu styling (for completion menu, search, etc.)
--       opts.popupmenu = {
--         backend = 'nui', -- nui gives nicer borders, position control
--         relative = 'editor',
--         position = {
--           row = 4, -- place it near the top
--           col = '50%', -- center horizontally
--         },
--         size = {
--           width = 60,
--           height = 10,
--         },
--         border = {
--           style = 'rounded',
--           padding = { 0, 1 },
--         },
--         win_options = {
--           winhighlight = {
--             Normal = 'Normal',
--             FloatBorder = 'FloatBorder',
--           },
--         },
--       }
--
--       -- LSP progress & messages
--       opts.lsp = {
--         progress = {
--           enabled = true,
--         },
--         hover = {
--           enabled = true,
--         },
--         signature = {
--           enabled = true,
--         },
--         message = {
--           enabled = true,
--         },
--       }
--
--       -- Routes (to clean up annoying messages if needed)
--       opts.routes = {
--         {
--           filter = { event = 'msg_show', kind = 'search_count' },
--           opts = { skip = true },
--         },
--       }
--     end,
--   },
-- }

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
