require("mason-lspconfig").setup({
  ensure_installed = {
    "cssls",
    "ts_ls",
    "html",
    "stylelint_lsp",
    "dockerls",
    "docker_compose_language_service",
    "postgres_lsp",
    "prismals",
    "lua_ls",
  },
  handlers = {
    function(server_name)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
      })
    end,
    ["cssls"] = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").cssls.setup({
        capabilities = capabilities,
        settings = {
          css = {
            lint = {
              emptyRules = "ignore",
              duplicateProperties = "warning",
            },
          },
          scss = {
            lint = {
              idSelector = "warning",
              zeroUnits = "warning",
              duplicateProperties = "warning",
              emptyRules = nil,
            },
            completion = {
              completePropertyWithSemicolon = true,
              triggerPropertyValueCompletion = true,
            },
          },
        },
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
      })
    end,
    ["stylelint_lsp"] = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").stylelint_lsp.setup({
        capabilities = capabilities,
        filetypes = { "css", "scss" },
        root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
        settings = {
          stylelintplus = {},
        },
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
      })
    end,
    ["prismals"] = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").prismals.setup({
        capabilities = capabilities,
        filetypes = { "prisma" },
        cmd = { "prisma-language-server", "--stdio" },
        root_dir = require("lspconfig").util.root_pattern("package.json", "prisma/schema.prisma", ".git"),
        settings = {
          prisma = {
            prismaFmtBinPath = "",
          },
        },
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
      })
    end,
    ["ts_ls"] = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
      })
    end,
    ["lua_ls"] = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "use", "vim", "Snacks" } },
            hint = { enable = true, setType = true },
            telemetry = { enable = false },
            workspace = {
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      })
    end,
  },
})