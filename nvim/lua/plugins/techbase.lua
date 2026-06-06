return {
  {
    "mcauley-penney/techbase.nvim",
    enabled = true,
    priority = 1000,
    opts = {
      transparent = true,
      hl_overrides = {
        -- 1. Fix Method & Function Calls (Links them to the definition blue)
        ["@function.call"] = { link = "Function" },
        ["@method.call"] = { link = "Function" },
        ["@lsp.type.method"] = { link = "Function" },
        ["@lsp.type.function"] = { link = "Function" },

        -- -- 2. Give variables a subtle, soft steel-blue tint (#8baedb)
        -- ["@variable"] = { fg = "#8baedb" },
        -- ["@variable.parameter"] = { fg = "#8baedb" },
        -- ["@lsp.type.variable"] = { fg = "#8baedb" },
        -- ["@lsp.type.parameter"] = { fg = "#8baedb" },
      },
    },
    config = function(_, opts)
      require("techbase").setup(opts)
      vim.cmd.colorscheme("hellbound")
      -- vim.cmd.colorscheme("techbase")
    end,
  },
}
