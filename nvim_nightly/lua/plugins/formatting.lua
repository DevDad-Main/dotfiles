local util = require("conform.util")

local biome_config = {
	"biome.json",
	"biome.jsonc",
	".biome.json",
	".biome.jsonc",
}

local eslint_config = {
	"eslint.config.js",
	"eslint.config.mjs",
	"eslint.config.cjs",
	"eslint.config.ts",
	"eslint.config.mts",
	"eslint.config.cts",
	".eslintrc",
	".eslintrc.json",
	".eslintrc.yml",
	".eslintrc.yaml",
	".eslintrc.js",
	".eslintrc.cjs",
}

local function project_formatters(bufnr, fallback)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	if vim.fs.root(filename, biome_config) then
		return { "biome-check" }
	end
	return fallback
end

local function javascript_formatters(bufnr)
	return project_formatters(bufnr, { "eslint", "prettierd" })
end

local function json_formatters(bufnr)
	return project_formatters(bufnr, { "prettierd" })
end

local function mason_formatter_command(name)
	return function()
		local ok, registry = pcall(require, "mason-registry")
		if ok and registry.is_installed(name) then
			local pkg = registry.get_package(name)
			local receipt = pkg:get_receipt()
			local bin = receipt and receipt:get() and receipt:get().links.bin[name]
			if bin then
				local path = pkg:get_install_path() .. "/" .. bin
				if vim.fn.filereadable(path) == 1 then
					return path
				end
			end
		end
		return name
	end
end

require("conform").setup({
	format_on_save = {
		timeout_ms = 8000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = javascript_formatters,
		javascriptreact = javascript_formatters,
		typescript = javascript_formatters,
		typescriptreact = javascript_formatters,
		graphql = { "prettierd" },
		go = { "goimports", "gofmt" },
		rust = { "rustfmt" },
		toml = { "taplo" },
		json = json_formatters,
		sql = { "sql_formatter" },
	},
	formatters = {
		eslint = {
			command = util.from_node_modules("eslint"),
			args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
			condition = function(_, ctx)
				return vim.fs.root(ctx.dirname, eslint_config) ~= nil
			end,
		},
		taplo = {
			command = mason_formatter_command("taplo"),
		},
		sql_formatter = {
			prepend_args = { "--language", "postgresql" },
		},
	},
})

require("nvim-ts-autotag").setup()
