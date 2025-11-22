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
  keymap = {
    -- preset = "enter",

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
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    min_keyword_length = function()
      return vim.bo.filetype == "markdown" and 4 or 0
    end,
    providers = {
      lsp = {
        fallbacks = {},
      },
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
      draw = { treesitter = { "lsp" } },
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
        auto_insert = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
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
}
