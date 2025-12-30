local conf_path = vim.fn.stdpath "config" --[[@as string]]

-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_config(name)
  return function()
    require("configs." .. name)
  end
end

return {
  -- test new blink
  { import = "nvchad.blink.lazyspec" },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = get_config "fzf",
  },
  { "rmagatti/auto-session", config = get_config "auto-session", event = "VimEnter" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require "configs.snacks",
  },
  { "stevearc/oil.nvim", event = "VeryLazy", config = get_config "oil" },
  {
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require "configs.ufo"
    end,
  },
  { "rlane/pounce.nvim", config = get_config "pounce", event = "VeryLazy" },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    -- dependencies = "rafamadriz/friendly-snippets",
    dependencies = {
      {
        {
          "supermaven-inc/supermaven-nvim",
          opts = {
            disable_keymaps = true, -- Allows us to use the default supermaven keymaps - Tab or C-]
            ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
          },
        },
      },
      -- "rafamadriz/friendly-snippets",
      "saghen/blink.compat",
    },
    version = "*",
    opts = require "configs.blink",
  },
  {
    "folke/lazydev.nvim",
    ft = "typescript",
    dependencies = { "DrKJeff16/wezterm-types" },
  },
  {
    --Note: Needed for blink.cmp menu
    "xzbdmw/colorful-menu.nvim",
    opts = {
      ls = {
        lua_ls = {
          arguments_hl = "@comment",
        },
        gopls = {
          align_type_to_right = true,
        },
      },
    },
  },
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = get_config "goto-preview", -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  },
  {

    "echasnovski/mini.nvim",
    version = false,
    keys = function()
      require("mappings").mini()
    end,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        package.loaded["nvim-web-devicons"] = {}
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    event = function()
      if vim.fn.argc() == 0 then
        return "VimEnter"
      else
        return { "InsertEnter", "LspAttach" }
      end
    end,

    config = function()
      local mini_config = require "mini_nvim"
      local mini_modules = {
        "icons",
        "comment",
        "starter",
        "pairs",
        "ai",
        "surround",
        "files",
        "hipatterns",
        "bufremove",
        "pick",
        "move",
        "extra",
        "visits",
        "clue",
        "git",
        "diff",
        "operators",
      }
      for _, module in ipairs(mini_modules) do
        require("mini." .. module).setup(mini_config[module])
      end
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    name = "dropbar",
    event = { "BufReadPost", "BufNewFile" },
    -- keys = {
    --   require("mappings").map({ "n" }, "<leader>p", function()
    --     require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count or nil)
    --   end, "Toggle dropbar menu"),
    -- },
    opts = {},
  },
  -- Here we initialize the options
  {
    name = "options",
    event = "VeryLazy",
    dir = conf_path,
    config = function()
      require("options").final()
      local maps = require "mappings"

      maps.core()
      maps.fzf()
      maps.git()
      maps.goto_preview()
      maps.lsp()
      maps.snacks()
      maps.mini()
      maps.misc()
    end,
  },
}
