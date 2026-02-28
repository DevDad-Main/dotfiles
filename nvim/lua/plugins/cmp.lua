return {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = "1.*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "Exafunction/windsurf.nvim",
    "supermaven-inc/supermaven-nvim",
  },
  event = "InsertEnter",
  config = function()
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    require("supermaven-nvim").setup({
      disable_inline_completion = false,
      keymaps = {
        accept_suggestion = "<Tab>",
      },
    })

    require("blink.cmp").setup({
      fuzzy = {
        implementation = "rust",
        sorts = { "score" },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
      },
      completion = {
        list = {
          max_items = 10,
          selection = { auto_insert = false },
        },
        ghost_text = { enabled = false },
        menu = {
          border = "single",
          scrollbar = false,
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                width = { fill = true, max = 25 },
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
          auto_show = true,
          window = { border = "single" },
        },
      },
      keymap = {
        ["<C-e>"] = { "select_and_accept" },
        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      sources = {
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
        window = { border = "single" },
      },
    })
  end,
}
