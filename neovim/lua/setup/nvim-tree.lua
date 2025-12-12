require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },

  view = {
    width = 40,
    side = "left",
    preserve_window_proportions = true,
  },

  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      git_placement = "after",
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
    },
  },

filters = {
    custom = { "node_modules", ".cache" },
    dotfiles = false, -- show dotfiles
    git_ignored = false, -- show .gitignored files
  },

  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
  },

  actions = {
    open_file = {
      resize_window = true, -- auto-resize window
      quit_on_open = true, -- close tree open when opening file
    },
  },

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
    -- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
  end,
})
