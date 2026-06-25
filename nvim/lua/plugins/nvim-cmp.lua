return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- Bind the custom highlight group directly to the completion menu selection
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:NormalFloat,Border:FloatBorder,CursorLine:CmpSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:NormalFloat,Border:FloatBorder,Search:None",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vim-dadbod-completion" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = (_G.tools.ui.kind_icons[vim_item.kind] or "") .. " "
          vim_item.menu = entry:get_completion_item().detail or ""
          return vim_item
        end,
      },
    })

    -- Function to keep completion suggestions dark and handle selection lines
    local function apply_custom_cmp_theme()
      -- Dims unselected completion item names and source details
      vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Comment" })
      vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "Comment" })

      -- Force icons to use your theme's orange require color (@function.builtin)
      -- vim.api.nvim_set_hl(0, "CmpItemKind", { link = "@function.builtin" })
      vim.api.nvim_set_hl(0, "CmpItemKind", { link = "Function" })

      -- Keeps matching typed letters popping out like your Telescope fuzzy matches
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "CmpItemAbbrMatch" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })

      -- Styled active line: Normal text foreground + CursorLine background
      vim.api.nvim_set_hl(0, "CmpSel", {
        fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg,
        bg = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg,
        bold = true,
      })
    end

    -- Run styling immediately
    apply_custom_cmp_theme()

    -- Enforce configuration lock so the theme cannot overwrite these rules
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = apply_custom_cmp_theme,
    })

    -- cmdline completion (: commands) with spanner icon
    cmp.setup.cmdline(":", {
      sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "cmdline_history" },
      }),
      mapping = cmp.mapping.preset.cmdline(),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
          vim_item.kind = " 󰒓 "
          vim_item.menu = ""
          return vim_item
        end,
      },
    })
  end,
}
