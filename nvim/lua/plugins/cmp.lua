return {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = "1.*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  event = "InsertEnter",
  config = function()
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()
    require("blink.cmp").setup({
      fuzzy = {
        implementation = "rust",
        sorts = { "score" },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
      },
      completion = {
        list = { max_items = 25 },
        menu = {
          border = "none",
          scrollbar = false,
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                width = { fill = true, max = 15 },
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = false,
          window = { border = "none" },
          -- auto_show_delay_ms = 500,
        },
      },
      keymap = {
        ["<C-e>"] = { "select_and_accept" },
        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },
        ["<CR>"] = { "accept", "fallback" },
      },
      sources = {
        -- default = { "lsp", "snippets", "path", "buffer" },
        default = { "lsp", "snippets", "path" },
        providers = {
          lsp = {
            async = true,
            fallbacks = { "buffer" },
          },
        },
      },
      signature = {
        enabled = true,
        window = { border = "none" },
      },
    })
  end,
}
