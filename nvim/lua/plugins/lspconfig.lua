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
      "docker_language_server",
      "docker_compose_language_service",
      "ts_ls",
      "tailwindcss",
    })

    -- Setup ts_ls with Mason paths using new API
    local mason_path = vim.fn.stdpath("data") .. "/mason"
    local mason_bin = mason_path .. "/packages/typescript-language-server/node_modules/.bin"
    local typescript_bin = mason_path .. "/packages/typescript-language-server/node_modules/typescript/bin"

    vim.lsp.config("ts_ls", {
      cmd = { mason_bin .. "/typescript-language-server", "--stdio" },
      init_options = {
        tsserver = {
          path = typescript_bin .. "/tsserver",
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
      root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", ".git" },
    })

    vim.lsp.config("tailwindcss", {
      cmd = { "tailwindcss-language-server", "--stdio" },
      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact", -- REQUIRED for .tsx
        "svelte",
      },
      root_markers = {
        "tailwind.config.js",
        "tailwind.config.ts",
        "postcss.config.js",
        "package.json",
        ".git",
      },
    })
  end,
}
