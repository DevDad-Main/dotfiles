---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  init_options = {
    hostInfo = "neovim",
    preferences = {
      providePrefixAndSuffixTextForRename = true,
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact", 
    "typescript",
    "typescriptreact",
  },
  settings = {
    vtsls = {
      format = { enable = true },
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
    },
    typescript = {
      preferences = {
        importModuleSpecifier = "non-relative",
        importModuleSpecifierEnding = "auto",
        quotePreference = "single",
        useAliasesForRenames = true,
      },
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = false },
        variableTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        functionLikeReturnTypes = { enabled = true },
      },
    },
  },
  root_dir = function(bufnr, on_dir)
    local root_markers = {
      "package-lock.json",
      "yarn.lock",
      "pnpm-lock.yaml", 
      "bun.lockb",
      "bun.lock",
    }

    root_markers = vim.fn.has("nvim-0.11.3") == 1
            and { root_markers, { ".git" } }
            or vim.list_extend(root_markers, { ".git" })

    if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
      return
    end

    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    on_dir(project_root)
  end,
}