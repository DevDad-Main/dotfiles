-- local capabilities = require("blink.cmp").get_lsp_capabilities()

-- lua/setup/lsp.lua
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- blink.cmp – safely get capabilities, with fallback
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink and blink and blink.get_lsp_capabilities then
  -- blink.cmp expects the base capabilities as argument
  capabilities = blink.get_lsp_capabilities(capabilities)
else
  -- Optional: warn once so you know it's missing
  vim.schedule(function()
    vim.notify_once("blink.cmp not fully initialized yet – using fallback LSP capabilities", vim.log.levels.WARN)
  end)
end

-- Now use `capabilities` in all your LSP setups below
-- (keep the rest of your file exactly as it is)
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

require("lspconfig").dockerls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

require("lspconfig").docker_compose_language_service.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
  capabilities = capabilities,
})

require("lspconfig").postgres_lsp.setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
  capabilities = capabilities,
})

--TODO:
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
