-- lua/plugins/mason.lua
return {
  "mason-org/mason.nvim",
  opts = {
    ui = {
      border = "rounded",
    },
    -- List of tools to install via mason
    ensure_installed = {
      -- LSPs
      "css-lsp",
      "emmet-ls",
      "eslint-lsp",
      "html-lsp",
      "json-lsp",
      "lua-language-server",
      -- "typescript-language-server",
      -- "yaml-language-server",
      -- "csharp-language-server",

      -- Formatters
      "prettier",
      "stylua",
      -- "pgformatter",
      -- "sql-formatter",
      -- "sqlfluff",
      -- "sqlfmt",
      "shfmt",

      -- Linters
      -- "shellcheck",
      "selene",

      -- Others
      -- "csharpier",
    },
  },
}
