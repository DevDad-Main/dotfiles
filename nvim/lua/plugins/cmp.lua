return {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = "1.*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "Exafunction/windsurf.nvim",
  },
  event = "InsertEnter",
  config = function()
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    local codeium_enabled = vim.fn.stdpath("data") .. "/codeium_enabled"
    local function is_codeium_enabled()
      return vim.fn.filereadable(codeium_enabled) == 1
    end

    local function toggle_codeium()
      if is_codeium_enabled() then
        vim.fn.delete(codeium_enabled)
        vim.notify("Codeium disabled", vim.log.levels.INFO)
        local ok, codeium = pcall(require, "codeium")
        if ok and codeium then codeium.setup({ enable_cmp_source = false, virtual_text = { enabled = false } }) end
      else
        local f = io.open(codeium_enabled, "w")
        if f then
          f:close()
          vim.notify("Codeium enabled", vim.log.levels.INFO)
        end
        local ok, codeium = pcall(require, "codeium")
        if ok and codeium then codeium.setup({ enable_cmp_source = false, virtual_text = { enabled = true } }) end
      end
      vim.cmd("Lazy reload blink.cmp")
    end

    vim.keymap.set("n", "<leader>ai", toggle_codeium, { desc = "Toggle Codeium AI completion" })

    require("codeium").setup({
      enable_cmp_source = false,
      virtual_text = {
        enabled = false,
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
        list = { max_items = 10 },
        menu = {
          border = "rounded",
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
          window = { border = "rounded" },
        },
      },
      keymap = {
        ["<C-e>"] = { "select_and_accept" },
        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      sources = {
        default = { "lsp", "snippets", "path", "codeium" },
        providers = {
          lsp = {
            async = true,
            fallbacks = { "buffer" },
          },
          codeium = {
            name = "Codeium",
            module = "codeium.blink",
            score_offset = function()
              return is_codeium_enabled() and 50 or -1000
            end,
            async = true,
          },
        },
      },
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },
    })
  end,
}
