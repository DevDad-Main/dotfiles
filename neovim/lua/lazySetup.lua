-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_setup(name)
  return function()
    require("setup." .. name)
  end
end

return {
  { "rebelot/kanagawa.nvim", config = get_setup("themes/kanagawa"), priority = 1000, lazy = false },

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
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   lazy = false,
  --   opts = {
  --     ensure_installed = {
  --       "c",
  --       "css",
  --       "scss",
  --       "typescript",
  --       "lua",
  --       "html",
  --       "javascript",
  --       "json",
  --       "php",
  --       "rust",
  --       "yaml",
  --       "vim",
  --       "toml",
  --       "java",
  --     },
  --     highlight = {
  --       enable = true,
  --     },
  --     incremental_selection = {
  --       enable = true,
  --       keymaps = {
  --         init_selection = "<CR>", -- start selection
  --         node_incremental = "<CR>", -- expand to next node
  --         scope_incremental = "<S-CR>", -- expand to scope
  --         node_decremental = "<TAB>", -- shrink selection
  --       },
  --     },
  --     indent = { enable = true },
  --   },
  --   config = function(_, opts)
  --     require("nvim-treesitter.configs").setup(opts)
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- use the newer rewritten branch
    lazy = false, -- load immediately
    build = ":TSUpdate", -- update parsers (still useful)
    config = function()
      local ts = require("nvim-treesitter")

      -- 1. Install parsers you need
      ts.install({
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "scss",
        "typescript",
        "vim",
        "yaml",
        "java",
      })
    end,
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
    opts = require("setup.blink"),
  },
  {
    "neovim/nvim-lspconfig",
    config = get_setup("lsp"),
    dependencies = { "saghen/blink.cmp" },
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
  { "EdenEast/nightfox.nvim", config = get_setup("nightfox"), enabled = false },
  { "folke/tokyonight.nvim", config = get_setup("tokyonight"), enabled = false },
  { "catppuccin/nvim", name = "catppuccin", config = get_setup("catppuccin"), enabled = false },

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
          "typescript-language-server",
          "jsonlint",
          "html-lsp",
          "dockerfile-language-server",
          "docker-compose-language-service",
          "hadolint", -- Docker Linter
          "pgformatter",
          "postgres-language-server",
          "prisma-language-server",
          "lua-language-server",
          "java-debug-adapter",
          "java-test",
          "jdtls",
          "google-java-format",
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
  {
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("configs.ufo")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = get_setup("nvim-tree"),
  },
  {
    "kyazdani42/nvim-tree.lua",
    config = get_setup("nvim-tree"),
    dependencies = {
      {
        "b0o/nvim-tree-preview.lua",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "3rd/image.nvim", -- Optional, for previewing images
        },
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = get_setup("mason-lspconfig"),
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "saghen/blink.cmp",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = get_setup("goto-preview"), -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  },
  { "typicode/bg.nvim", lazy = false },
}
