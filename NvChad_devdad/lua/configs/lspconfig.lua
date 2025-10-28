-- Load defaults from NvChad (adapted for new API)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
})

local on_attach = function(client, bufnr)
  -- Add your custom on_attach logic here
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      group = "lsp_document_highlight",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
      desc = "Clear highlight references",
      buffer = bufnr,
      group = "lsp_document_highlight",
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local methods = vim.lsp.protocol.Methods

local ok, _ = pcall(require, "ufo")
if ok then
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
end

---gopls_organize_imports will organize imports for the provided buffer
---@param client vim.lsp.Client gopls instance
---@param bufnr number buffer to organize imports for
local function organize_imports(client, bufnr)
  local gopls = vim.lsp.get_clients { bufnr = bufnr, name = "gopls" }
  if not gopls or #gopls == 0 then
    return -- Exit if no gopls client is found
  end

  local params = vim.lsp.util.make_range_params(0, gopls[1].offset_encoding)
  params.context = { only = { "source.organizeImports" } }

  local resp = client.request_sync("textDocument/codeAction", params, 3000, bufnr)
  for _, r in pairs(resp and resp.result or {}) do
    if r.edit then
      vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding or "utf-16")
    else
      vim.lsp.buf.execute_command(r.command)
    end
  end
end

local custom_on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  if client.server_capabilities.textDocument then
    if client.server_capabilities.textDocument.codeLens then
      require("virtualtypes").on_attach(client, bufnr)

      vim.api.nvim_create_autocmd({ "BufReadPost", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh { bufnr = bufnr }
        end,
      })

      vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { buffer = bufnr, silent = true })
    end
  end

  if client.server_capabilities.signatureHelpProvider then
    vim.lsp.handlers["textDocument/signatureHelp"] = require("noice").signature
  end

  require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

  if client.server_capabilities.documentHighlightProvider then
    -- Already handled in on_attach
  end
end

local go_on_attach = function(client, bufnr)
  if client.name ~= "gopls" then
    return
  end

  custom_on_attach(client, bufnr)
  organize_imports(client, bufnr)

  vim.opt.formatprg = ""

  -- Go
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      organize_imports(client, bufnr)
      -- vim.lsp.buf.format { async = false }
    end,
  })
end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return
  end

  custom_on_attach(client, vim.api.nvim_get_current_buf())

  return register_capability(err, res, ctx)
end

vim.lsp.handlers["textDocument/hover"] = require("noice").hover
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
  local ts_lsp = { "ts_ls", "angularls", "volar", "vtsls" }
  local clients = vim.lsp.get_clients { id = ctx.client_id }
  if vim.tbl_contains(ts_lsp, clients[1].name) then
    local filtered_result = {
      diagnostics = vim.tbl_filter(function(d)
        return d.severity == 1
      end, result.diagnostics),
    }
  end
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
end

-- Enable LSP servers
local servers = {
  "html",
  "cssls",
  "clangd",
  -- "astro",
  "marksman",
  "emmet_ls",
  "jsonls",
  "dockerls",
  "dockerfile-language-server",
  "docker-compose-language-service",
  "lua_ls",
  "vuels",
  -- "yamlls",
  "terraformls",
  "vtsls",
  "typescript-language-server",
  "omnisharp-mono",
  "gopls",
  "kulala_ls",
  "eslint",
  "copilot",
  "pyright",
  "postgrestools",
  "prismals",
}
vim.lsp.enable(servers)

-- Customize LSP configurations
vim.lsp.config("lua_ls", {
  on_attach = custom_on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "use", "vim", "Snacks" } },
      hint = { enable = true, setType = true },
      telemetry = { enable = false },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

vim.lsp.config("kulala_ls", { on_attach = custom_on_attach })
vim.lsp.config("copilot", { on_attach = custom_on_attach })
vim.lsp.config("dockerls", { on_attach = custom_on_attach })
vim.lsp.config("dockerfile-language-server", { on_attach = custom_on_attach })
vim.lsp.config("docker-compose-language-service", { on_attach = custom_on_attach })
vim.lsp.config("pyright", { on_attach = custom_on_attach, capabilities = capabilities })
vim.lsp.config("postgresstools", { on_attach = custom_on_attach, capabilities = capabilities })

vim.lsp.config("prismals", {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  filetypes = { "prisma" }, -- This is CRITICAL
  cmd = { "prisma-language-server", "--stdio" },
  root_dir = require("lspconfig.util").root_pattern("package.json", "prisma/schema.prisma", ".git"),
  settings = {
    prisma = {
      prismaFmtBinPath = "", -- Let it auto-detect
    },
  },
})

vim.lsp.config("jsonls", {
  on_attach = custom_on_attach,
  settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
})
-- vim.lsp.config("yamlls", {
--   on_attach = custom_on_attach,
--   settings = {
--     yaml = {
--       schemaStore = { url = vim.env.SCHEMA_NEXUS, enable = true },
--       schemas = {
--         [vim.env.SCHEMA_BACKEND] = ".gitlab-ci.yml",
--         [vim.env.SCHEMA_DOCKER] = ".gitlab-ci.yml",
--         [vim.env.SCHEMA_HELM] = ".gitlab-ci.yml",
--       },
--     },
--   },
-- })
vim.lsp.config("eslint", {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    -- "astro",
  },
  cmd = { "vscode-eslint-language-server", "--stdio" },
  handlers = {
    ["eslint/confirmESLintExecution"] = function(_, result)
      return result and 4 or nil
    end,
    ["eslint/noLibrary"] = function()
      return {}
    end,
    ["eslint/probeFailed"] = function()
      vim.notify("[lspconfig] ESLint probe failed.", vim.log.levels.WARN)
      return {}
    end,
  },
  root_dir = require("lspconfig").util.root_pattern(
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "package.json"
  ),
  settings = {
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
    codeActionOnSave = { enable = false, mode = "all" },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    packageManager = "npm",
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = { mode = "location" },
  },
})

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.lsp"
local pid = vim.fn.getpid()

vim.lsp.config("omnisharp-mono", {
  cmd = {
    vim.fn.stdpath "data" .. "/mason/packages/omnisharp-mono/run",
    "--languageserver",
    "--hostPID",
    tostring(pid),
  },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "cs", "vb" },
  -- root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj"),
  enable_editorconfig_support = true,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  enable_decompilation_support = true,
})
-- vim.lsp.config("omnisharp-mono", {
--   cmd = {
--     "omnisharp-mono",
--     "--languageserver",
--     "--hostPID",
--     tostring(pid),
--     "dotnet",
--     vim.fn.stdpath "data" .. "\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll",
--   },
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   filetypes = { "cs", "vb" }, -- 🧠 this line fixes the warning
-- })

vim.lsp.config("typescript-language-server", { on_attach = custom_on_attach }, {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    hostInfo = "neovim",
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsWithInsertText = true,
      importModuleSpecifierPreference = "relative",
      quotePreference = "auto",
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
      },
    },
  },
})
vim.lsp.config("vtsls", {
  on_attach = custom_on_attach,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    -- "astro",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = { completion = { enableServerSideFuzzyMatch = true, entriesLimit = 50 } },
    },
    javascript = { updateImportsOnFileMove = { enabled = "always" }, suggest = { completeFunctionCalls = true } },
    typescript = {
      format = { indentSize = vim.o.shiftwidth, convertTabsToSpaces = vim.o.expandtab, tabSize = vim.o.tabstop },
      preferences = {
        importModuleSpecifier = "non-relative",
        includePackageJsonAutoImports = "off",
        autoImportFileExcludePatterns = { ".git", "node_modules" },
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = false },
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
})
vim.lsp.config("gopls", {
  on_attach = go_on_attach,
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gosum", "goimpl", "gohtmltmpl", "gotexttmpl", "gohtml", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  init_options = { usePlaceholders = true },
  flags = { debounce_text_changes = 150 },
  settings = {
    gopls = {
      buildFlags = { "-tags=wireinject" },
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      usePlaceholders = true,
      experimentalPostfixCompletions = true,
      completeUnimported = true,
      vulncheck = "Imports",
      gofumpt = true,
      staticcheck = true,
      semanticTokens = true,
      matcher = "Fuzzy",
      symbolMatcher = "FastFuzzy",
      diagnosticsDelay = "500ms",
      analyses = {
        fieldalignment = true,
        shadow = true,
        fillreturns = true,
        nonewvars = true,
        staticcheck = true,
        structure = true,
        unparam = true,
        deadcode = true,
        nilness = true,
        typeparams = true,
        ST1000 = false,
        unusedwrite = true,
        unusedparams = true,
        useany = true,
        unusedresult = true,
      },
      codelenses = { test = true, generate = false, run_govulncheck = true, vendor = true },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- Custom handlers
vim.lsp.handlers["textDocument/formatting"] = function(err, result, ctx, _)
  if err ~= nil or result == nil then
    return
  end
  if not vim.api.nvim_buf_get_option(ctx.bufnr, "modified") then
    local view = vim.fn.winsaveview()
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    vim.lsp.util.apply_text_edits(result, ctx.bufnr, client.offset_encoding)
    vim.fn.winrestview(view)
    if ctx.bufnr == vim.api.nvim_get_current_buf() or not ctx.bufnr then
      vim.api.nvim_command "noautocmd :update"
    end
  end
end

vim.lsp.handlers["textDocument/hover"] = require("noice").hover
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
  local ts_lsp = { "ts_ls", "angularls", "volar", "vtsls" }
  local clients = vim.lsp.get_clients { id = ctx.client_id }
  if vim.tbl_contains(ts_lsp, clients[1].name) then
    local filtered_result =
      { diagnostics = vim.tbl_filter(function(d)
        return d.severity == 1
      end, result.diagnostics) }
  end
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
end

require("lspconfig.ui.windows").default_options.border = "rounded"

local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
for type, icon in pairs(signs) do
  local hl = "Diagnostic" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local x = vim.diagnostic.severity
vim.diagnostic.config {
  virtual_lines = false,
  virtual_text = { prefix = "■", spacing = 2 },
  float = {
    border = "rounded",
    format = function(diagnostic)
      return diagnostic.source and string.format("%s [%s]", diagnostic.message, diagnostic.source) or diagnostic.message
    end,
    severity_sort = true,
    close_events = { "CursorMoved", "InsertEnter" },
  },
  signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}
