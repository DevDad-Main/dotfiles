-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/telescope.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/telescope.lua
--
-- https://github.com/nvim-telescope/telescope.nvim

local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

return {
  {
    'nvim-telescope/telescope.nvim',
    opts = function()
      return {
        defaults = {
          mappings = {
            i = {
              --INFO: Ctrl - c closes the window
              -- Preview scrolling with u and d
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
              -- Allow us to move up and down with j k
              -- ["<C-j>"] = actions.move_selection_next,
              -- ["<C-k>"] = actions.move_selection_previous,
              --INFO: Don't need this as Ctrl-c closes the window when in insert mode for both fzf and buffers
              -- ["<C-q>"] = actions.close, -- Closes the Window when in insert mode
            },
            n = {
              ['q'] = actions.close, -- Closes the Window when in normal mode
              ['d'] = actions.delete_buffer, -- Delete buffer in insert mode
            },
          },
          -- When I search for stuff in telescope, I want the path to be shown
          -- first, this helps in files that are very deep in the tree and I
          -- cannot see their name.
          -- Also notice the "reverse_directories" option which will show the
          -- closest dir right after the filename
          path_display = {
            filename_first = {
              reverse_directories = true,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--sortr=modified' },
          },
        },
      }
    end,
    keys = {
      -- I swapped ff and fF because I normally use ff
      -- fF is NOT working properly as it only finds sibling files of current file, but I don't care
      -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#find-sibling-files-of-current-file
      -- I figured I needed to use 'telescope.builtin' on the telescope github page
      -- {
      --   "<leader>fF",
      --   function()
      --     require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
      --   end,
      --   desc = "Find Files (cwd)",
      -- },
      -- {
      --   "<leader>ff",
      --   function()
      --     require("telescope.builtin").find_files({})
      --   end,
      --   desc = "Find Files (root dir)",
      -- },

      -- I tried disabling this keymap, but I couldn't
      -- So fuck it, I'm adding the keymap that I need here, which is to
      -- alternate between the last 2 files
      --
      -- I also tried overwriting this keymap in keymaps.lua but it was always
      -- overriden by this telescope.lua file
      -- http://www.lazyvim.org/extras/editor/telescope#telescopenvim
      {
        '<leader>fz',
        function()
          builtin.find_files { cwd = vim.loop.cwd() }
        end,
        desc = 'Find Files (Root Dir)',
      },
      { '<leader>fF', '<cmd>Telescope frecency<cr>', desc = 'Find Files (cwd)' },
      -- {
      --   "<leader>ff",
      --   "<cmd>Telescope frecency workspace=CWD path_display={'shorten'} theme=ivy<cr>",
      --   desc = "Find Files (Root Dir)",
      -- },
      {
        '<leader><space>',
        '<cmd>Telescope frecency workspace=CWD theme=ivy<cr>',
        desc = 'Find Files (Root Dir)',
      },
      {
        '<leader>sG',
        function()
          builtin.live_grep { cwd = vim.loop.cwd() }
        end,
        desc = 'Grep (cwd)',
      },
      { '<leader>sg', builtin.live_grep, desc = 'Grep (Root Dir)' },
      {
        '<Tab>',
        '<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>',
        desc = 'Alternate buffer',
      },
      {
        '<leader>tl',
        '<cmd>TodoTelescope keywords=TODO<cr>',
        desc = '[P]TODO list (Telescope)',
      },
      {
        '<leader>ta',
        '<cmd>TodoTelescope keywords=PERF,HACK,TODO,NOTE,FIX<cr>',
        desc = '[P]TODO list ALL (Telescope)',
      },
    },
  },
}
