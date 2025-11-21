local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Give me rounded borders everywhere
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- LSP Server config
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
-- require("lspconfig").ts_ls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = function(client)
-- 		client.server_capabilities.document_formatting = false
-- 	end,
-- })

require("lspconfig").html.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

require("lspconfig").stylelint_lsp.setup({
  filetypes = { "css", "scss" },
  root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
  settings = {
    stylelintplus = {
      -- see available options in stylelint-lsp documentation
    },
  },
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

require("lspconfig").vtsls.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
})

vim.lsp.config("dockerls", {
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

-- vim.lsp.config("dockerfile-language-server", { on_attach = custom_on_attach })
-- vim.lsp.config("docker-compose-language-service", { on_attach = custom_on_attach })
-- vim.lsp.config("postgres-language-server", { on_attach = custom_on_attach, capabilities = capabilities })

require("lspconfig").lua_ls.setup({
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

-- require("lspconfig").eslint.setup({
--   root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
--   on_attach = function(client)
--     client.server_capabilities.document_formatting = false
--   end,
-- })

-- LSP Prevents inline buffer annotations
vim.diagnostic.open_float()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
})
