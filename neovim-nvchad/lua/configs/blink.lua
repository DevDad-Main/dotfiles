local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    return false
  end
  local before = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(1, col)
  return not before:match "^%s*$"
end

return {
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "supermaven",
      -- "buffer",
    },
    providers = {
      lsp = { fallbacks = { "lazydev" } },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      supermaven = {
        module = "blink.compat.source",
        score_offset = 80,
        async = true,
      },
      snippets = { preset = "luasnip" },
    },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
  },
  completion = {
    documentation = {
      window = {
        border = "rounded",
        winblend = 15,
      },
    },
    menu = {
      min_width = 25,
      max_height = 30,
      -- draw = { treesitter = { "lsp" } },
      draw = {
        align_to = "cursor",
        columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
      scrollbar = false,
      border = "rounded",
      winblend = 5,
      winhighlight = "Normal:CmpNormal",
    },
    ghost_text = { enabled = false },
    list = {
      selection = {
        preselect = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        -- auto_insert = function(ctx)
        --   return ctx.mode ~= "cmdline"
        -- end,
        auto_insert = false,
      },
      max_items = 50,
      cycle = {
        from_bottom = true,
        from_top = true,
      },
    },
  },
  documentation = {
    auto_show = true,
    auto_show_delay_ms = 500,
  },
  signature = {
    enabled = false, --NOTE: NVChad already has this enabled by default so we disable blinks to prevent duplicates
    window = {
      border = "rounded",
      winblend = 15,
    },
  },
  keymap = {
    -- ╭─────────────────────────────────────────────────────────╮
    -- │ Allows us to press enter to accept the suggestion       │
    -- │ while overwritting the default behaviour, Pressing tab  │
    -- │ while in the menu wont work                             │
    -- ╰─────────────────────────────────────────────────────────╯
    preset = "enter",

    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<Tab>"] = {
      function()
        if not has_words_before() then
          return
        end

        local suggestion = require "supermaven-nvim.completion_preview"
        if suggestion.has_suggestion() then
          vim.schedule(function()
            suggestion.on_accept_suggestion()
          end)
        end
        return true
      end,
    },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<Esc>"] = {
      "cancel",
      "fallback",
    },
    ["Enter"] = { "select_and_accept", "fallback" },
  },
}
