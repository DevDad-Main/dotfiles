-- e.g. in your `plugins.js` or `plugins.lua` file for lazy.nvim

return {
  -- other plugins...
  {
    "heavenshell/vim-jsdoc",
    ft = { "javascript", "javascript.jsx", "typescript", "typescriptreact" }, -- only load for JS/TS files
    build = "make install", -- to install lehre etc.
    config = function()
      -- optional configuration settings
      -- set formatter, template path, etc.
      vim.g.jsdoc_formatter = "jsdoc" -- or "esdoc" or "tsdoc"
      -- if you installed lehre somewhere else, set it:
      -- vim.g.jsdoc_lehre_path = "/path/to/node_modules/.bin/lehre"
    end,
  },

  -- other plugins...
}
