return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "b0o/nvim-tree-preview.lua",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "3rd/image.nvim", -- Optional, for previewing images
    },
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- nvim-tree-preview compat: newer nvim-tree doesn't expose `.config` on the main module
    local _nvim_tree = require("nvim-tree")
    _nvim_tree.config = setmetatable({}, {
      __index = function(_, k)
        local cfg = require("nvim-tree.config")
        return cfg.g and cfg.g[k] or cfg.d[k]
      end,
    })

    nvimtree.setup({
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        -- Important: When you supply an `on_attach` function, nvim-tree won't
        -- automatically set up the default keymaps. To set up the default keymaps,
        -- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local preview = require("nvim-tree-preview")

        vim.keymap.set("n", "P", preview.watch, opts("Preview (Watch)"))
        vim.keymap.set("n", "<Esc>", preview.unwatch, opts("Close Preview/Unwatch"))
        vim.keymap.set("n", "<C-f>", function()
          return preview.scroll(4)
        end, opts("Scroll Down"))
        vim.keymap.set("n", "<C-b>", function()
          return preview.scroll(-4)
        end, opts("Scroll Up"))

        -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
        vim.keymap.set("n", "<Tab>", function()
          local ok, node = pcall(api.tree.get_node_under_cursor)
          if ok and node then
            if node.type == "directory" then
              api.node.open.edit()
            else
              preview.node(node, { toggle_focus = true })
            end
          end
        end, opts("Preview"))

        -- Option B: Simple tab behavior: Always preview
        -- vim.keymap.set("n", '<Tab>', preview.node_under_cursor, opts 'Preview')
      end,
      view = {
        width = 40,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              -- arrow_closed = "", -- arrow when folder is closed
              -- arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    require("nvim-tree-preview").setup({
      keymaps = {
        ["<Esc>"] = { action = "close", unwatch = true },
        ["<Tab>"] = { action = "toggle_focus" },
        ["<CR>"] = { open = "edit" },
        ["<C-t>"] = { open = "tab" },
        ["<C-v>"] = { open = "vertical" },
        ["<C-x>"] = { open = "horizontal" },
        ["<C-n>"] = { action = "select_node", target = "next" },
        ["<C-p>"] = { action = "select_node", target = "prev" },
      },
      min_width = 10,
      min_height = 5,
      max_width = 85,
      max_height = 35,
      wrap = false,
      border = "rounded",
      zindex = 100,
      show_title = true,
      title_pos = "top-left",
      title_format = " %s ",
      follow_links = true,
      win_position = {},
      image_preview = {
        enable = false,
        patterns = {
          ".*%.png$",
          ".*%.jpg$",
          ".*%.jpeg$",
          ".*%.gif$",
          ".*%.webp$",
          ".*%.avif$",
        },
      },
      on_open = nil,
      on_close = nil,
      watch = {
        event = "CursorMoved",
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ne", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>nc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>nr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
