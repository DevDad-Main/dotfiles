return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
        html = { "prettierd", "prettier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
          stdin = true,
          cwd = require("conform.util").root_file({ ".editorconfig", "*.sln", "*.csproj" }),
        },
      },
    },
  },
}
