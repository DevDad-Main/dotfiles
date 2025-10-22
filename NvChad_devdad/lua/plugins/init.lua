local overrides = require "configs.overrides"
local blink_opt = require "configs.blink"

return {
  { import = "nvchad.blink.lazyspec" },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "supermaven-inc/supermaven-nvim",
        opts = {
          disable_keymaps = true,
          ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
        },
      },
      "saghen/blink.compat",
    },
    opts = blink_opt.blink,
  },
  {
    "windwp/nvim-autopairs",
    enabled = false,
  },
  {
    "saghen/blink.pairs",
    version = "*",
    dependencies = "saghen/blink.download",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      highlights = {
        enabled = true,
        groups = {
          "BlinkPairsRed",
          "BlinkPairsOrange",
          "BlinkPairsYellow",
          "BlinkPairsGreen",
          "BlinkPairsCyan",
          "BlinkPairsBlue",
          "BlinkPairsViolet",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "artemave/workspace-diagnostics.nvim",
    },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "folke/which-key.nvim",
    enabled = false,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "hrsh7th/cmp-path",
    enabled = false,
  },
  {
    "https://codeberg.org/FelipeLema/cmp-async-path.git",
    enabled = false,
  },
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
  },
  {
    "nvzone/volt",
    event = "BufReadPost",
    dependencies = {
      "nvzone/minty",
      "nvzone/menu",
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = overrides.devicons,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- branch = "master",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    opts = overrides.treesitter,
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.go_tags = {
        install_info = {
          url = "https://github.com/DanWlker/tree-sitter-go_tags",
          files = { "src/parser.c" },
          branch = "main",
        },
      }
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "antosha417/nvim-lsp-file-operations" },
    opts = require "configs.tree",
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      require("nvim-tree.diagnostics").update_lsp()
    end,
  },
  {
    "NStefan002/visual-surround.nvim",
    event = "InsertEnter",
    config = function()
      require("visual-surround").setup {
        use_default_keymaps = false,
        exit_visual_mode = false,
      }
      local surround_chars = { "{", "[", "(", "'", '"', "<" }
      local surround = require("visual-surround").surround

      for _, key in pairs(surround_chars) do
        vim.keymap.set("v", "s" .. key, function()
          surround(key)
        end, { desc = "[visual-surround] Surround selection with " .. key })
      end
    end,
  },
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    ---@type snacks.Config
    opts = {
      animate = {
        ---@type snacks.animate.Duration|number
        enabled = true,
        duration = 20,
        easing = "linear",
        fps = 60,
      },
      scroll = {
        enabled = true,
        animate = {
          duration = {
            step = 15,
            total = 250,
          },
          easing = "outQuad",
        },
        animate_repeat = {
          delay = 100,
          duration = { step = 5, total = 50 },
          easing = "outQuad",
        },
        image = {
          resolve = function(path, src)
            if require("obsidian.api").path_is_note(path) then
              return require("obsidian.api").resolve_image_path(src)
            end
          end,
        },
      },
      -- lazygit = { enabled = true },
      indent = { enabled = true },
    },
  },
  {
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
  ----------------------------------------- enhance plugins ------------------------------------------
  -- {
  --   "okuuva/auto-save.nvim",
  --   event = { "InsertLeave", "TextChanged" },
  --   config = function()
  --     require "configs.autosave"
  --   end,
  -- },
  {
    "soulis-1256/eagle.nvim",
    opts = {},
  },
  {
    "gbprod/cutlass.nvim",
    event = "BufReadPost",
    opts = {
      cut_key = "x",
      override_del = true,
      exclude = {},
      registers = {
        select = "_",
        delete = "_",
        change = "_",
      },
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        enabled = true,
        auto_save = true,
        auto_restore = true,
        git_use_branch_name = true,
      }
    end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    event = {
      "BufReadPre /users/bruno.krugel/Library/Mobile Documents/iCloud~md~obsidian/Documents/Annotation/**.md",
    },
    dependencies = {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        heading = {
          sign = false,
          icons = { " ", " ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          width = 79,
        },
        code = {
          sign = false,
          width = "block",
          right_pad = 1,
        },
        dash = {
          width = 79,
        },
        bullet = {
          right_pad = 1,
        },
        pipe_table = {
          style = "full",
        },
      },
    },
    config = function()
      require("obsidian").setup {
        dir = "/users/bruno.krugel/Library/Mobile Documents/iCloud~md~obsidian/Documents/Annotation",
        disable_frontmatter = true,
        workspaces = {
          {
            name = "Annotation",
            path = "~/users/bruno.krugel/Library/Mobile Documents/iCloud~md~obsidian/Documents/Annotation",
          },
        },
        legacy_commands = false,
        attachments = {
          image_text_func = function(path)
            local name = vim.fs.basename(tostring(path))
            local encoded_name = require("obsidian.util").urlencode(name)
            return string.format("![%s](%s)", name, encoded_name)
          end,
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        markdown_link_func = function(opts)
          return string.format("[%s](%s)", opts.label, opts.path)
        end,
        statusline = {
          enabled = false, -- turn it off
        },
        ui = {
          enable = true,
          update_debounce = 200,
          checkboxes = {
            [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
            [">"] = { char = "", hl_group = "ObsidianRightArrow" },
            ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          },
          bullets = { char = "•", hl_group = "ObsidianBullet" },
          external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
          reference_text = { hl_group = "ObsidianRefText" },
          highlight_text = { hl_group = "ObsidianHighlightText" },
          tags = { hl_group = "ObsidianTag" },
        },
      }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = { "DrKJeff16/wezterm-types" },
    opts = {
      library = {
        { path = vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types", words = { "ChadrcConfig", "NvPluginSpec" } },
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
  {
    "m-demare/hlargs.nvim",
    event = "LspAttach",
    opts = {
      hl_priority = 200,
      extras = { named_parameters = true },
    },
  },
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      winbar = true,
      icons = {
        inlay = {
          loading = "",
          done = "",
          error = "",
        },
      },
    },
  },
  {
    "smoka7/hop.nvim",
    cmd = { "HopWord", "HopLine", "HopLineStart", "HopWordCurrentLine", "HopNodes" },
    config = function()
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },
  {
    "nguyenvukhang/nvim-toggler",
    event = "BufReadPost",
    config = function()
      require("nvim-toggler").setup {
        remove_default_keybinds = true,
      }
    end,
  },
  {
    "nvim-mini/mini.surround",
    event = { "ModeChanged" },
    ops = {},
  },
  {
    "wakatime/vim-wakatime",
    event = "BufReadPost",
  },
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapStepOver", "DapStepInto", "DapStepOut", "DapToggleBreakpoint" },
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup {
            highlight_changed_variables = true,
            virt_text_pos = "eol",
            highlight_new_as_changed = true,
            show_stop_reason = true,
            commented = true,
          }
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require "configs.dapui"
        end,
      },
    },
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    ft = "go",
    config = function()
      require("persistent-breakpoints").setup {
        load_breakpoints_event = { "BufReadPost" },
      }
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },
    config = function()
      local map = vim.keymap.set

      require("grug-far").setup {}

      local is_grugfar_open = function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = vim.api.nvim_get_option_value("filetype", { buf = buf })
          if buf_name and buf_name == "grug-far" then
            return true
          end
        end
        return false
      end

      local toggle_grugfar = function()
        local open = is_grugfar_open()
        if open then
          require "grug-far/actions/close"()
        else
          vim.cmd "GrugFar"
        end
      end

      map("n", "<leader>gr", function()
        toggle_grugfar()
      end, { desc = "Toggle GrugFar" })
    end,
  },
  ----------------------------------------- ui plugins ------------------------------------------
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          top_down = false,
        },
        init = function()
          local banned_messages = {
            "No information available",
          }
          vim.notify = function(msg, ...)
            for _, banned in ipairs(banned_messages) do
              if msg == banned then
                return
              end
            end
            return require "notify"(msg, ...)
          end
        end,
      },
    },
    config = function()
      require "configs.noice"
      ---@diagnostic disable-next-line: different-requires
      vim.lsp.handlers["textDocument/hover"] = require("noice").hover
      ---@diagnostic disable-next-line: different-requires
      vim.lsp.handlers["textDocument/signatureHelp"] = require("noice").signature
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require "configs.todo"
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup {
        modes = {
          project_diagnostics = {
            mode = "diagnostics",
            filter = {
              any = {
                {
                  function(item)
                    return item.filename:find(vim.fn.getcwd(), 1, true)
                  end,
                },
              },
            },
          },
          mydiags = {
            mode = "diagnostics",
            filter = {
              any = {
                buf = 0,
                {
                  severity = vim.diagnostic.severity.ERROR,
                  function(item)
                    return item.filename:find(true, 1, (vim.uv or vim.uv).cwd())
                  end,
                },
              },
            },
          },
        },
        auto_close = true,
        keys = {
          ["<Esc>"] = "close",
          ["<cr>"] = "jump_close",
        },
      }
    end,
  },
  {
    "b0o/schemastore.nvim",
    ft = { "json", "yaml", "yml" },
  },
  {
    "BrunoKrugel/muren.nvim",
    cmd = "MurenToggle",
    config = true,
  },
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    opts = {
      default_mappings = {
        ours = "<leader>gco",
        theirs = "<leader>gct",
        none = "<leader>gc0",
        both = "<leader>gcb",
        next = "]c",
        prev = "[c",
      },
      disable_diagnostics = true,
      list_opener = function()
        require("trouble").open "quickfix"
      end,
    },
  },
  {
    "kevinhwang91/nvim-fundo",
    event = "BufReadPost",
    opts = {},
    build = function()
      require("fundo").install()
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    config = function()
      require "configs.statuscol"
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require "configs.ufo"
    end,
  },
  {
    "VonHeikemen/searchbox.nvim",
    cmd = { "SearchBoxMatchAll", "SearchBoxReplace", "SearchBoxIncSearch" },
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
            diff_binaries = false,
            winbar_info = true,
          },
        },
        hooks = {
          diff_buf_win_enter = function(_, _, ctx)
            if ctx.layout_name:match "^diff2" then
              if ctx.symbol == "a" then
                vim.opt_local.winhl = table.concat({
                  "DiffAdd:DiffviewDiffAddAsDelete",
                  "DiffDelete:DiffviewDiffDelete",
                }, ",")
              elseif ctx.symbol == "b" then
                vim.opt_local.winhl = table.concat({
                  "DiffDelete:DiffviewDiffDelete",
                }, ",")
              end
            end
          end,
        },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          for _, view in ipairs(require("diffview.lib").views) do
            view:close()
          end
        end,
      })
    end,
  },
  {
    "0xAdk/full_visual_line.nvim",
    keys = { "V", "v" },
    config = function()
      require("full_visual_line").setup {}
    end,
  },
  {
    "wurli/visimatch.nvim",
    keys = { "V", "v" },
    opts = {
      hl_group = "Visual",
    },
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          require "hover.providers.lsp"
          require "hover.providers.dap"
          require "hover.providers.fold_preview"
          require "hover.providers.diagnostic"
        end,
        preview_opts = {
          border = "single",
        },
        preview_window = false,
        title = true,
        mouse_providers = {
          "LSP",
        },
        mouse_delay = 1000,
      }
    end,
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "BufReadPost",
    opts = {
      overwrite = {
        redo = {
          enabled = true,
          default_animation = {
            settings = {
              from_color = "DiffAdd",
            },
          },
        },
        undo = {
          enabled = true,
          default_animation = {
            settings = {
              from_color = "DiffDelete",
            },
          },
        },
      },
    },
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function()
      require "configs.symbol"
    end,
  },
  {
    "Chaitanyabsprip/fastaction.nvim",
    opts = {
      dismiss_keys = { "<ESC>", "q" },
    },
  },
  {
    "folke/edgy.nvim",
    event = "BufReadPost",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      fix_win_height = vim.fn.has "nvim-0.10.0" == 0,
      bottom = {
        {
          ft = "toggleterm",
          size = { height = 0.1 },
        },
        { ft = "qf", title = "QuickFix" },
        { ft = "dap-repl", size = { height = 0.2 }, title = " Debug REPL" },
        { ft = "dapui_console", size = { height = 0.2 }, title = "Debug Console" },
        "Trouble",
        "Noice",
        {
          ft = "NoiceHistory",
          title = " Log",
          open = function()
            ---@diagnostic disable-next-line: different-requires
            require("noice").cmd "history"
          end,
        },
        {
          ft = "neotest-output-panel",
          title = " Test Output",
          open = function()
            vim.cmd.vsplit()
            require("neotest").output_panel.toggle()
          end,
        },
        {
          ft = "trouble",
          title = "Diagnostics",
          size = { height = 0.3 },
        },
        {
          ft = "DiffviewFileHistory",
          title = " Diffs",
        },
      },
      left = {
        { ft = "undotree", title = "Undo Tree" },
        { ft = "dapui_scopes", title = " Scopes" },
        { ft = "dapui_watches", title = " Watches" },
        { ft = "dapui_stacks", title = " Stacks" },
        { ft = "dapui_breakpoints", title = " Breakpoints" },
        {
          ft = "diff",
          title = " Diffs",
        },
        {
          ft = "DiffviewFileHistory",
          title = " Diffs",
        },
        {
          ft = "DiffviewFiles",
          title = " Diffs",
        },
        {
          ft = "grug-far",
          title = "Replace",
          size = { width = 0.2 },
        },
        {
          ft = "neotest-summary",
          title = "  Tests",
          open = function()
            require("neotest").summary.toggle()
          end,
        },
      },
      right = {
        "dapui_scopes",
        "sagaoutline",
        "neotest-output-panel",
        "neotest-summary",
      },
      options = {
        left = { size = 40 },
        bottom = { size = 10 },
        right = { size = 30 },
        top = { size = 10 },
      },
      wo = {
        winbar = true,
        signcolumn = "no",
      },
    },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-\>]] },
    cmd = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll" },
    opts = {
      size = function(term)
        -- if term.direction == "horizontal" then
        --   return 0.25 * vim.api.nvim_win_get_height(0)
        -- elseif term.direction == "vertical" then
        --   return 0.25 * vim.api.nvim_win_get_width(0)
        if term.direction == "float" then
          -- elseif term.direction == "float" then
          return 85
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,
      insert_mappings = true,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      autochdir = true,
      highlights = {
        NormalFloat = {
          link = "Normal",
        },
        FloatBorder = {
          link = "FloatBorder",
        },
      },
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
    },
  },
  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPost",
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- This disables or enables the plugin
    -- I'm switching over to mini.files (mini-files.lua) because neotree had
    -- some issues for me, when renaming files or directories sometimes they
    -- didn't update so had to be using oil.nvim
    enabled = true,
    keys = {
      -- I'm using these 2 keyamps already with mini.files, so avoiding conflict
      { "<leader>e", false },
      { "<leader>E", false },
      -- -- I swapped these 2
      -- { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      -- { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      -- New mapping for spacebar+r to reveal in NeoTree
      -- New mapping for spacebar+r to reveal in NeoTree with toggle functionality

      -- -- When I press <leader>r I want to show the current file in neo-tree,
      -- -- But if neo-tree is open it, close it, to work like a toggle
      {
        "<C-p>p",
        function()
          local buf_name = vim.api.nvim_buf_get_name(0)
          -- Function to check if NeoTree is open in any window
          local function is_neo_tree_open()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "neo-tree" then
                return true
              end
            end
            return false
          end
          -- Check if the current file exists
          if vim.fn.filereadable(buf_name) == 1 or vim.fn.isdirectory(vim.fn.fnamemodify(buf_name, ":p:h")) == 1 then
            if is_neo_tree_open() then
              -- Close NeoTree if it's open
              vim.cmd "Neotree close"
            else
              -- Open NeoTree and reveal the current file
              vim.cmd "Neotree filesystem reveal left"
            end
          else
            -- If the file doesn't exist, execute the logic for <leader>R
            require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() }
          end
        end,
        desc = "[P]Toggle current file in NeoTree or open cwd if file doesn't exist",
      },
      {
        "<leader>R",
        function()
          require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() }
        end,
        desc = "Explorer NeoTree (cwd)",
      },

      -- {
      --   "<leader>r",
      --   function()
      --     vim.cmd("Neotree reveal")
      --   end,
      --   desc = "Reveal current file in NeoTree",
      -- },
    },
    opts = {
      source_selector = {
        winbar = true,
        statusline = false,
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
        -- Had to disable this option, because when I open neotree it was
        -- jumping around to random dirs when I opened a dir
        follow_current_file = { enabled = false },

        -- ###################################################################
        --                     custom delete command
        -- ###################################################################
        -- Adding custom commands for delete and delete_visual
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/202#issuecomment-1428278234
        commands = {
          -- over write default 'delete' command to 'trash'.
          delete = function(state)
            if vim.fn.executable "trash" == 0 then
              vim.api.nvim_echo({
                { "- Trash utility not installed. Make sure to install it first\n", nil },
                { "- In macOS run `brew install trash`\n", nil },
                { "- Or delete the `custom delete command` section in neo-tree", nil },
              }, false, {})
              return
            end
            local inputs = require "neo-tree.ui.inputs"
            local path = state.tree:get_node().path
            local msg = "Are you sure you want to trash " .. path
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end

              vim.fn.system { "trash", vim.fn.fnameescape(path) }
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
          -- Overwrite default 'delete_visual' command to 'trash' x n.
          delete_visual = function(state, selected_nodes)
            if vim.fn.executable "trash" == 0 then
              vim.api.nvim_echo({
                { "- Trash utility not installed. Make sure to install it first\n", nil },
                { "- In macOS run `brew install trash`\n", nil },
                { "- Or delete the `custom delete command` section in neo-tree", nil },
              }, false, {})
              return
            end
            local inputs = require "neo-tree.ui.inputs"

            -- Function to get the count of items in a table
            local function GetTableLen(tbl)
              local len = 0
              for _ in pairs(tbl) do
                len = len + 1
              end
              return len
            end

            local count = GetTableLen(selected_nodes)
            local msg = "Are you sure you want to trash " .. count .. " files?"
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              for _, node in ipairs(selected_nodes) do
                vim.fn.system { "trash", vim.fn.fnameescape(node.path) }
              end
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
        },
        -- ###################################################################
      },
    },
  },
  ----------------------------------------- language plugins ------------------------------------------
  {
    "nvim-neotest/neotest",
    ft = { "go", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = {
      "nvim-neotest/neotest-go",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      ---@diagnostic disable-next-line: different-requires
      require "configs.neotest"
    end,
  },
  {
    "andythigpen/nvim-coverage",
    cmd = "Coverage",
    opts = {
      auto_reload = true,
      lang = {
        go = {
          coverage_file = vim.fn.getcwd() .. "/coverage.out",
        },
      },
      signs = {
        covered = { hl = "CoverageCovered", text = "│" },
        uncovered = { hl = "CoverageUncovered", text = "│" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "LspAttach",
    config = function()
      require "configs.linter"
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    "chrisgrieser/nvim-recorder",
    keys = { "q", "Q" },
    opts = {
      slots = { "a", "b", "c", "d", "e", "f", "g" },
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        editMacro = "<leader>qe",
        switchSlot = "<leader>qt",
      },
      lessNotifications = true,
      clear = false,
      logLevel = vim.log.levels.INFO,
      dapSharedKeymaps = false,
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").setup {
        extensions = {
          frecency = {
            show_scores = true, -- Default: false
            -- If `true`, it shows confirmation dialog before any entries are removed from the DB
            -- If you want not to be bothered with such things and to remove stale results silently
            -- set db_safe_mode=false and auto_validate=true
            --
            -- This fixes an issue I had in which I couldn't close the floating
            -- window because I couldn't focus it
            db_safe_mode = false, -- Default: true
            -- If `true`, it removes stale entries count over than db_validate_threshold
            auto_validate = true, -- Default: true
            -- It will remove entries when stale ones exist more than this count
            db_validate_threshold = 10, -- Default: 10
            -- Show the path of the active filter before file paths.
            -- So if I'm in the `dotfiles-latest` directory it will show me that
            -- before the name of the file
            show_filter_column = false, -- Default: true
          },
        },
      }
      require("telescope").load_extension "frecency"
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "eslint_d",
          "prettierd",
          "stylua",
          "typescript-language-server",
          "vtsls",
          "jsonlint",
          "html-lsp",
          -- NOTE: If On Arch or other linux distros ensure to install mono/mono-msbuild/dotnet-sdk
          "omnisharp-mono",
          "csharpier",
          "dockerfile-language-server",
          "docker-compose-language-service",
          "hadolint",
        },
      }
    end,
    -- NOTE: Uncomment this to install the fool list of packages in the custom.chadrc -> uncomment and run :MasonToolsInstall
    --   config = function()
    --   require("mason-tool-installer").setup {
    --     ensure_installed = require("custom.chadrc").mason.pkgs,   -- reuse the existing list
    --     auto_update = false,
    --     run_on_start = true,
    --     start_delay = 2000,
    --     debounce_hours = 5,
    --   }
    -- end,
  },
  {
    "barrett-ruth/live-server.nvim",
    -- build = "npm install -g live-server", -- Installs live-server globally if needed
    ft = { "html", "css", "javascript", "typescript", "markdown" }, -- Optional, only loads for these filetypes
    config = function()
      require("live-server").setup {
        -- Optional settings
        open_browser = true,
        port = 8080,
      }
    end,
  },
  {
    "brianhuster/live-preview.nvim",
    event = "VeryLazy",
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>lc", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGitCurrentFile" },
    },
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
}
