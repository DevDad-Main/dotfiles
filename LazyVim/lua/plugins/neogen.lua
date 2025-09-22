-- e.g. in your `plugins.js` or `plugins.lua` file for lazy.nvim

return {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip", -- Optional: If you want snippet integration (LazyVim has this by default)
  },
  config = function()
    local neogen = require("neogen")
    neogen.setup({
      snippet_engine = "luasnip", -- Integrates with LuaSnip for placeholder jumping
      enabled = true,
      languages = {
        javascript = {
          template = {
            annotation_convention = "jsdoc", -- Default for JS; change if needed (e.g., to "tsdoc" for TypeScript-like)
          },
        },
        -- Add javascriptreact if you use JSX
        javascriptreact = {
          template = {
            annotation_convention = "jsdoc",
          },
        },
      },
    })

    -- Optional keybindings (adapt to your workflow; <Leader> is usually "\")
    vim.keymap.set("n", "<Leader>ng", function()
      neogen.generate()
    end, { desc = "Neogen: Generate annotation" })
    vim.keymap.set("n", "<Leader>nf", function()
      neogen.generate({ type = "func" })
    end, { desc = "Neogen: Generate function annotation" })
    vim.keymap.set("n", "<Leader>nc", function()
      neogen.generate({ type = "class" })
    end, { desc = "Neogen: Generate class annotation" })
    vim.keymap.set("n", "<Leader>nt", function()
      neogen.generate({ type = "type" })
    end, { desc = "Neogen: Generate type annotation" })
    vim.keymap.set("n", "<Leader>na", function()
      neogen.generate({ type = "file" })
    end, { desc = "Neogen: Generate file annotation" })
  end,
  version = "*", -- Optional: Lock to stable versions
}
