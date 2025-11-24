-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_setup(name)
  return function()
    require("setup." .. name)
  end
end

return {
  -- { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "stevearc/oil.nvim", event = "VeryLazy", config = get_setup("oil") },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = get_setup("conform"),
  },
  { "mbbill/undotree" },
  { "LudoPinelli/comment-box.nvim", event = "VeryLazy" },
  { "numToStr/Comment.nvim", lazy = false, config = get_setup("comment") },
  { "rlane/pounce.nvim", config = get_setup("pounce") },
  {
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine"),
    event = "VeryLazy",
  },
  {
    "folke/which-key.nvim",
    config = get_setup("which-key"),
    event = "VeryLazy",
  },
  { "brenoprata10/nvim-highlight-colors", config = get_setup("highlight-colors") },
  {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("setup.snacks"),
  },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
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
    opts = require("setup.blink"),
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = get_setup("gitsigns"),
  },
  {
    "neovim/nvim-lspconfig",
    config = get_setup("lsp"),
    dependencies = { "saghen/blink.cmp" },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = get_setup("fzf"),
  },
  { "rmagatti/auto-session", config = get_setup("auto-session") },
  { "echasnovski/mini.ai", config = get_setup("mini-ai"), version = false },
  { "echasnovski/mini.bracketed", config = get_setup("mini-bracketed"), version = false },
  { "echasnovski/mini.move", config = get_setup("mini-move"), version = false },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  {
    "windwp/nvim-autopairs",
    config = get_setup("autopairs"),
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  -- NOTE: Themes
  { "rebelot/kanagawa.nvim", config = get_setup("themes.kanagawa"), priority = 1000, lazy = false, enabled = true },
  { "EdenEast/nightfox.nvim", config = get_setup("themes.nightfox"), enabled = false },
  { "folke/tokyonight.nvim", config = get_setup("themes.tokyonight"), enabled = false },
  {
    "ellisonleao/gruvbox.nvim",
    config = get_setup("themes.gruvbox"),
    priority = 1000,
    lazy = false,
    enabled = false,
  },
  { "catppuccin/nvim", name = "catppuccin", config = get_setup("themes.catppuccin"), enabled = false },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = get_setup("themes.zenbones"),
    priority = 1000,
    lazy = false,
    enabled = false,
  },
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-neotest/neotest",
    ft = { "go", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = {
      "nvim-neotest/neotest-go",
      "nvim-neotest/nvim-nio",
      "marilari88/neotest-vitest",
    },
    config = function()
      ---@diagnostic disable-next-line: different-requires
      require("configs.neotest")
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "eslint_d",
          "prettierd",
          "stylua",
          "vtsls",
          "jsonlint",
          "html-lsp",
          "dockerfile-language-server",
          "docker-compose-language-service",
          "hadolint", -- Docker Linter
          "pgformatter",
          "postgres-language-server",
          "prisma-language-server",
          "lua-language-server",
        },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("configs.todo")
    end,
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
    "folke/lazydev.nvim",
    ft = "typescript",
    dependencies = { "DrKJeff16/wezterm-types" },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

        local extends = {
          typescript = { "tsdoc" },
          javascript = { "jsdoc" },
          lua = { "luadoc" },
          python = { "pydoc" },
          rust = { "rustdoc" },
          cs = { "csharpdoc" },
          java = { "javadoc" },
          c = { "cdoc" },
          cpp = { "cppdoc" },
          php = { "phpdoc" },
          kotlin = { "kdoc" },
          ruby = { "rdoc" },
          sh = { "shelldoc" },
        }
        -- friendly-snippets - enable standardized comments snippets
        for ft, snips in pairs(extends) do
          require("luasnip").filetype_extend(ft, snips)
        end
      end,
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  { "nvim-mini/mini.files", version = false, config = get_setup("mini-files") },
}
