-- enhanced, a and i keybinds
require("mini.ai").setup()

-- auto pairs
require("mini.pairs").setup()

-- access to surround keymaps sa,sd,sc etc
require("mini.surround").setup()

-- icons, replace nvim_web_devicons
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- better jump capabilities
require("mini.jump").setup()

-- move current line up/down with ]e / [e
require("mini.move").setup({
	mappings = {
		left = "",
		right = "",
		down = "",
		up = "",
		line_left = "",
		line_right = "",
		line_down = "]e",
		line_up = "[e",
	},
})
