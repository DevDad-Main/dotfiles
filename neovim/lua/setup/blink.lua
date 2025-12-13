-- TODO: Move this to each individual theme so we can have custom CmpNormal bgs for each theme.
vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#202029" })

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    return false
  end
  local before = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(1, col)
  return not before:match("^%s*$")
end

return {
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    ghost_text = { enabled = false }, -- Supermaven handles this better
    list = {
      selection = {
        preselect = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        auto_insert = false,
      },
      max_items = 40,
      cycle = {
        from_bottom = true,
        from_top = true,
      },
    },
    trigger = {
      show_on_trigger_character = true,
    },
    documentation = { 
      auto_show = true, 
      auto_show_delay_ms = 300,
      window = { 
        border = "rounded",
        winblend = 15,
        winhighlight = "Normal:NormalFloat",
      } 
    },
    menu = {
      border = "rounded",
      winblend = 5,
      winhighlight = "Normal:CmpNormal",
      min_width = 30,
      max_height = 25,
      draw = {
        padding = 0,
        columns = { 
          { "kind_icon", gap = 1 }, 
          { gap = 1, "label" }, 
          { "kind", gap = 2 } 
        },
        components = {
          kind_icon = {
            text = function(ctx)
              return " " .. ctx.kind_icon .. " "
            end,
            highlight = function(ctx)
              return "BlinkCmpKindIcon" .. ctx.kind
            end,
          },
          kind = {
            text = function(ctx)
              return " " .. ctx.kind .. " "
            end,
          },
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
    },
  },
  sources = {
    default = { "git", "dictionary", "lsp", "supermaven", "snippets", "path", "buffer" },
    providers = {
      git = {
        module = "blink-cmp-git",
        name = "Git",
        enabled = function()
          return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
        end,
        opts = {},
        score_offset = 120,
      },
      dictionary = {
        module = "blink-cmp-dictionary",
        name = "Dict",
        min_keyword_length = 3,
        opts = {},
        score_offset = 80,
      },
      lsp = { 
        fallbacks = { "lazydev" },
        min_keyword_length = 1,
        score_offset = 200, -- Highest priority
      },
      supermaven = {
        module = "blink.compat.source",
        score_offset = 150, -- High priority
        async = true,
      },
      snippets = { 
        preset = "luasnip",
        score_offset = 100,
      },
      path = {
        min_keyword_length = 2,
        fallback = false,
        score_offset = 50,
      },
      buffer = {
        min_keyword_length = 2,
        fallback = false,
        score_offset = 0,
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 180,
      },
    },
    per_filetype = {
      lua = { 
        inherit_defaults = true, 
        "lazydev" 
      },
    },
  },
  signature = {
    enabled = true,
    window = {
      border = "rounded",
      winblend = 15,
      winhighlight = "Normal:NormalFloat",
    },
    trigger = {
      show_on_insert = true,
      show_on_trigger_character = true,
    },
  },
  fuzzy = { implementation = "prefer_rust" },
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

        local suggestion = require("supermaven-nvim.completion_preview")
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
