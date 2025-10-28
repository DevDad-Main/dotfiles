local conform = require "conform"

---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

conform.setup {
  notify_on_error = false,
  formatters_by_ft = {
    javascript = { "prettierd" },
    c_sharp = { "csharpier" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    python = { "black" },
    json = { "prettierd" },
    jsonc = { "prettier" },
    css = { "prettierd" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    query = { "format-queries" },
    lua = { "stylua" },
    http = { "kulala-fmt" },
    -- sql = { "sqlfmt" },
    sql = { "pgformatter" },
    go = function(bufnr)
      return { first(bufnr, "goimports", "gofumpt") }
    end,
    ["vue"] = { "prettier" },
    ["scss"] = { "prettier" },
    ["less"] = { "prettier" },
    ["yaml"] = { "prettierd" },
    ["markdown.mdx"] = { "prettier" },
    ["graphql"] = { "prettier" },
    ["handlebars"] = { "prettier" },
    ["_"] = { lsp_format = "first" },
    ["*"] = { "trim_whitespace", "trim_newlines", "keep-sorted" },
  },
  format_on_save = {
    timeout_ms = 500,
    lspformat = "fallback",
  },
}
