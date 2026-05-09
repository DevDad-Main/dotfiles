-- return {
--   "folke/noice.nvim",
--   event = "VeryLazy",
--   opts = {
--     presets = {
--       bottom_search = false,
--       command_palette = false,
--       long_message_to_split = false,
--       inc_rename = false,
--       lsp_doc_border = true,
--     },
--   },
--
--   dependencies = {
--     "MunifTanjim/nui.nvim",
--   },
-- }

return {
  "folke/noice.nvim",
  event = "VeryLazy",

  opts = {
    -- disable cmdline UI
    cmdline = {
      enabled = false,
    },

    -- disable popupmenu UI
    popupmenu = {
      enabled = false,
    },

    -- disable messages
    messages = {
      enabled = false,
    },

    notify = {
      enabled = false,
    },

    presets = {
      lsp_doc_border = true,
    },

    -- optional but cleaner
    lsp = {
      progress = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
      hover = {
        enabled = true,
      },
    },
  },

  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
