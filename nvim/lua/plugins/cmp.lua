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
        -- ["<C-j>"] = { "select_next" },
        -- ["<C-k>"] = { "select_prev" },
        -- ["<C-j>"] = {
        --   function(cmp)
        --     if cmp.is_visible() then
        --       return cmp.select_next()
        --     else
        --       -- return proper keycode sequence
        --       return vim.api.nvim_replace_termcodes("<C-o>j", true, false, true)
        --     end
        --   end,
        --   "fallback",
        -- },
        ["<C-j>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            else
              local line = vim.api.nvim_win_get_cursor(0)[1] -- current line
              local last_line = vim.api.nvim_buf_line_count(0) -- total lines
              if line == last_line then
                -- at last line, insert a new line
                return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
              else
                -- move down normally
                return vim.api.nvim_replace_termcodes("<C-o>j", true, false, true)
              end
            end
          end,
          "fallback",
        },
        ["<C-k>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            else
              return vim.api.nvim_replace_termcodes("<C-o>k", true, false, true)
            end
          end,
          "fallback",
        },
        ["<CR>"] = { "accept", "fallback" },
        -- ["<C-h>"] = { "hide" },
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
