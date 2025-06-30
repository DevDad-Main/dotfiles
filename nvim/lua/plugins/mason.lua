-- lua/plugins/mason.lua
return {
  "williamboman/mason.nvim",
  opts = {
    -- List of tools to install via mason
    ensure_installed = {
      -- LSPs
      -- "tailwindcss-language-server",
      "css-lsp",
      "emmet-ls",
      "eslint-lsp",
      "html-lsp",
      "json-lsp",
      "lua-language-server",
      -- "typescript-language-server",
      "yaml-language-server",
      -- "csharp-language-server",

      -- Formatters
      "prettier",
      "stylua",
      "pgformatter",
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
