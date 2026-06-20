return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Auto-install tools after Mason is ready
    vim.defer_fn(function()
      local tools_to_install = {
        "prettier",
        "prettierd",
        "stylua",
        "eslint_d",
        "tailwindcss-language-server",
        "typescript-language-server",
        "json-lsp",
        "prisma-language-server",
        "lemminx",
        "docker-language-server",
        "lua-language-server",
      }

      local mr = require("mason-registry")
      for _, tool in ipairs(tools_to_install) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end, 1000)
  end,
}
