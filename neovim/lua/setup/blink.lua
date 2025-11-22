-- TODO: Move this to each individiual theme so we can have custom CmpNormal bgs for each theme.
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
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  -- sources = {
  --   default = { "lsp", "path", "snippets", "buffer" },
  --   qq
  --   min_keyword_length = function()
  --     return vim.bo.filetype == "markdown" and 4 or 0
  --   end,
  --   providers = {
  --     lsp = {
  --       fallbacks = {},
  --     },
  --   },
  -- },
  sources = {
    default = {
      "supermaven",
      "lsp",
      "path",
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
        score_offset = 100,
        async = true,
      },
      snippets = {
        name = "snippets",
        enabled = true,
        max_items = 20,
        min_keyword_length = 2,
        module = "blink.cmp.sources.snippets",
        score_offset = 85, -- the higher the number, the higher the priority
        -- FIX: This function only lets you have snippets when you type ; then the snippet - I don't want that as i want everything alwasys accessible
        -- should_show_items = function()
        --   local col = vim.api.nvim_win_get_cursor(0)[2]
        --   local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
        --   -- NOTE: remember that `trigger_text` is modified at the top of the file
        --   return before_cursor:match(trigger_text .. "%w*$") ~= nil
        -- end,

        -- After accepting the completion, delete the trigger_text characters
        -- from the final inserted text
        -- Modified transform_items function based on suggestion by `synic` so
        -- that the luasnip source is not reloaded after each transformation
        -- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
        -- NOTE: I also tried to add the ";" prefix to all of the snippets loaded from
        -- friendly-snippets in the luasnip.lua file, but I was unable to do
        -- so, so I still have to use the transform_items here
        -- This removes the ";" only for the friendly-snippets snippets
        transform_items = function(_, items)
          local line = vim.api.nvim_get_current_line()
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local before_cursor = line:sub(1, col)
          local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
          if start_pos then
            for _, item in ipairs(items) do
              if not item.trigger_text_modified then
                ---@diagnostic disable-next-line: inject-field
                item.trigger_text_modified = true
                item.textEdit = {
                  newText = item.insertText or item.label,
                  range = {
                    start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
                    ["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
                  },
                }
              end
            end
          end
          return items
        end,
      },
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
    ghost_text = { enabled = true },
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
    enabled = true,
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
