return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- cs = { "csharpier" },
        html = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier", stop_after_first = true },
      },
      -- -- This will allow us to have prettier used with our EJS files
      -- formatters = {
      --   prettier = {
      --     args = function(ctx)
      --       if vim.endswith(ctx.filename, ".ejs") then
      --         return { "--stdin-filepath", "$FILENAME", "--parser", "html" }
      --       end
      --       return { "--stdin-filepath", "$FILENAME" }
      --     end,
      --   },
      -- },
      -- Only required if we will make something in Unity
      -- formatters = {
      --   csharpier = {
      --     command = "dotnet-csharpier",
      --     args = { "--write-stdout" },
      --     stdin = true,
      --     cwd = require("conform.util").root_file({ ".editorconfig", "*.sln", "*.csproj" }),
      --   },
      -- },
    },
  },
}
