return {
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        -- omnisharp = {
        --   enable_roslyn_analysers = true,
        --   enable_import_completion = true,
        --   organize_imports_on_format = true,
        --   enable_decompilation_support = true,
        --   filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets", "tproj", "slngen", "fproj" },
        -- },
        cssls = {},
        -- tailwindcss = {
        --   root_dir = function(...)
        --     return require("lspconfig.util").root_pattern(".git")(...)
        --   end,
        -- },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            -- typescript = {
            --   inlayHints = {
            --     includeInlayParameterNameHints = "literal",
            --     includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            --     includeInlayFunctionParameterTypeHints = true,
            --     includeInlayVariableTypeHints = false,
            --     includeInlayPropertyDeclarationTypeHints = true,
            --     includeInlayFunctionLikeReturnTypeHints = true,
            --     includeInlayEnumMemberValueHints = true,
            --   },
            -- },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "tab",
                  indent_size = "4",
                  continuation_indent_size = "4",
                },
              },
            },
          },
        },
      },
      setup = {},
    },
    -- REMOVE THIS LINE IF WE WANT TO USE REGULAR LSP DIAGNOSTICS
    -- Disable virtual_text since it's redundant due to lsp_lines.
    -- vim.diagnostic.config({
    --   virtual_text = false,
    -- }),
  },
  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
