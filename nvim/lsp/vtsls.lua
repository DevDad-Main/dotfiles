---@brief
---
--- https://github.com/yioneko/vtsls
---
--- `vtsls` can be installed with npm:
--- ```sh
--- npm install -g @vtsls/language-server
--- ```
---
--- To configure a TypeScript project, add a
--- [`tsconfig.json`](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html)
--- or [`jsconfig.json`](https://code.visualstudio.com/docs/languages/jsconfig) to
--- the root of your project.
---
--- Monorepo support is enabled by default.

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

	-- We will let the default new lsp formatting handle it. If issues then resort to conform
	-- on_attach = function(client)
	-- 	-- Let prettier / external formatters handle formatting
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- 	client.server_capabilities.documentRangeFormattingProvider = false
	-- end,

	root_dir = function(bufnr, on_dir)
		-- Lockfile-first root detection (monorepo friendly)
		local root_markers = {
			"package-lock.json",
			"yarn.lock",
			"pnpm-lock.yaml",
			"bun.lockb",
			"bun.lock",
		}

		-- Equal priority with .git
		root_markers = vim.fn.has("nvim-0.11.3") == 1
				and { root_markers, { ".git" } }
				or vim.list_extend(root_markers, { ".git" })

		-- Exclude Deno projects
		if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
			return
		end

		-- Fallback to CWD if nothing is found
		local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
		on_dir(project_root)
	end,
}
