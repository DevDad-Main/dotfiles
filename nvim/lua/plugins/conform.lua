return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo", "Format" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },

        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },

        css = { "prettierd" },
        json = { "prettierd" },
        markdown = { "prettierd" },
        html = { "prettierd" },
        yaml = { "prettierd" },
      },
      formatters = {
        stylua = {
          command = vim.fn.expand("~/.local/share/nvim/mason/bin/stylua"),
          args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
        },
        prettierd = {
          command = vim.fn.expand("~/.local/share/nvim/mason/bin/prettierd"),
        },
      },
      format_on_save = { timeout_ms = 1500, lsp_format = "never" },
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })
  end,
}
