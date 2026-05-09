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
      "json_ls",
      "prismals",
      "jdtls",
      "xmlls",
      "lemminx",
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

    vim.lsp.config("json_ls", {
      cmd = { mason_path .. "/packages/json-lsp/node_modules/.bin/vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      root_markers = { "package.json", ".git" },
    })

    vim.lsp.config("prismals", {
      cmd = { mason_path .. "/packages/prisma-language-server/node_modules/.bin/prisma-language-server", "--stdio" },
      filetypes = { "prisma" },
      root_markers = { ".git", "package.json" },
    })

    local jdtls_path = mason_path .. "/packages/jdtls/bin/jdtls"
    local java_home = vim.fn.expand("$HOME/.sdkman/candidates/java/current")
    local lombok_jars =
      vim.fn.glob(vim.fn.expand("~/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar"), false, true)
    local lombok_jar = lombok_jars[#lombok_jars] -- takes the newest version

    vim.lsp.config("jdtls", {
      cmd = {
        "java",
        "-javaagent:" .. lombok_jar,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        jdtls_path,
      },
      cmd_env = {
        JAVA_HOME = java_home,
      },
      filetypes = { "java" },
      root_markers = { "build.gradle", "pom.xml", "settings.gradle", ".git" },
      -- capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.lsp.config("xmlls", {
      cmd = { "xml" },
      filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "xhtml" },
      root_markers = { "pom.xml", "build.xml", ".git" },
    })
  end,
}
