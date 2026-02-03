return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    require("luasnip").setup({ enable_autosnippets = true })
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}