return {
  -- Core Copilot client (handles inline ghost text)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true, -- enable inline ghost text
          auto_trigger = true, -- show automatically as you type
          debounce = 75,
          keymap = {
            accept = "<Return>", -- accept inline suggestion
            next = "<M-]>", -- next suggestion
            prev = "<M-[>", -- previous suggestion
            dismiss = "<C-]>", -- dismiss inline suggestion
          },
        },
        panel = { enabled = false }, -- no side panel
      })
    end,
  },

  -- Blink source for Copilot (integrates AI into completion menu)
  {
    "giuxtaposition/blink-cmp-copilot",
    dependencies = { "saghen/blink.cmp" },
    -- Remove the config function, as it's handled in blink-cmp.lua
  },
}
