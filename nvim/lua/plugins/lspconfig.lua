return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Enable LSPs using Mason-managed servers
    vim.lsp.enable({
      "lua_ls",
      "cssls",
      "svelte", 
      "rust_analyzer",
      "clangd",
      "ruff",
      "glsl_analyzer",
      "haskell-language-server",
      "hlint",
      "intelephense",
      "emmet_language_server",
      "emmet_ls",
      "solargraph",
      "zls",
      "pyright",
    })
    
    -- Setup ts_ls with Mason paths
    local mason_path = vim.fn.stdpath("data") .. "/mason"
    local mason_bin = mason_path .. "/packages/typescript-language-server/node_modules/.bin"
    local typescript_bin = mason_path .. "/packages/typescript-language-server/node_modules/typescript/bin"
    
    require("lspconfig").ts_ls.setup({
      cmd = { mason_bin .. "/typescript-language-server", "--stdio" },
      init_options = {
        tsserver = {
          path = typescript_bin .. "/tsserver"
        },
        preferences = {
          includeCompletionsForModuleExports = true,
        },
      },
      filetypes = {
        "javascript",
        "javascriptreact", 
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      root_dir = function(bufnr)
        local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", ".git" }
        return vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
      end,
      single_file_support = true,
    })
  end,
}