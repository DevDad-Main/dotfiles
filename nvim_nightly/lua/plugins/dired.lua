require("dired").setup({
	path_separator = "/",
	show_icons = false,
	show_hidden = true,
	show_dot_dirs = true,
	show_banner = false,
	show_colors = true,
	override_cwd = true,
})

vim.keymap.set("n", "-", ":Dired<CR>", { silent = true, desc = "Open dired" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "dired",
	callback = function()
		local opts = { buffer = 0, silent = true }
		vim.keymap.set("n", "l", "<Plug>(dired_enter)", opts)
		vim.keymap.set("n", "h", "<Plug>(dired_up)", opts)
		vim.keymap.set("n", "=", function()
			local cmd = vim.fn.input("Enter command in dir: ", "", "shellcmd")
			if cmd ~= "" then
				vim.cmd("botright terminal " .. cmd)
			end
		end, opts)
	end,
})