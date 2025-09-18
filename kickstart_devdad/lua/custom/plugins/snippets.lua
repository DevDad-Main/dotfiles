-- file: lua/plugins/snippets.lua

return {
  {
    -- LuaSnip is the snippet engine
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    dependencies = {
      -- Friendly snippets collection
      {
        'rafamadriz/friendly-snippets',
        -- optional config for friendly-snippets
        config = function()
          -- load all friendly-snippets (vscode style)
          require('luasnip.loaders.from_vscode').lazy_load()
          -- also load custom snippets from your config/snippets folder
          require('luasnip.loaders.from_vscode').lazy_load {
            paths = { vim.fn.stdpath 'config' .. '/snippets' },
            -- you can also filter to only JS or exclude other langs
            -- e.g. include only javascript/javascriptreact/typescript
          }
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
      -- you can add more LuaSnip options here
    },
    config = function(plugin, opts)
      local luasnip = require 'luasnip'
      -- apply options
      luasnip.config.setup(opts)

      -- Keybindings for jumping through snippet placeholders
      -- adjust keymaps as you like
      vim.keymap.set({ 'i', 's' }, '<Tab>', function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          -- fallback to normal tab
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', false)
        end
      end, { silent = true, noremap = true })

      vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true, noremap = true })
    end,
  },
}
