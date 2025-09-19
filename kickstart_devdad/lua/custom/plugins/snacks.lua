-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/snacks.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/snacks.lua

-- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
-- https://github.com/folke/snacks.nvim/blob/main/docs/image.md

-- NOTE: If you experience an issue in which you cannot select a file with the
-- snacks picker when you're in insert mode, only in normal mode, and you use
-- the bullets.vim plugin, that's the cause, go to that file to see how to
-- resolve it
-- https://github.com/folke/snacks.nvim/issues/812

return {
  {
    'folke/snacks.nvim',
    lazy = false, -- load on startup so require("snacks") always works
    priority = 1000,
    keys = function()
      local Snacks = require 'snacks'
      return {
        { '<leader>e', false },
        {
          '<leader>sg',
          function()
            Snacks.picker.grep {
              exclude = { 'dictionaries/words.txt' },
            }
          end,
          desc = 'Grep',
        },
        {
          '<leader>gl',
          function()
            Snacks.picker.git_log {
              finder = 'git_log',
              format = 'git_log',
              preview = 'git_show',
              confirm = 'git_checkout',
              layout = 'vertical',
            }
          end,
          desc = 'Git Log',
        },
        {
          '<leader>tt',
          function()
            Snacks.picker.grep {
              prompt = ' ',
              search = '^\\s*- \\[ \\]',
              regex = true,
              live = false,
              dirs = { vim.fn.getcwd() },
              args = { '--no-ignore' },
              on_show = function()
                vim.cmd.stopinsert()
              end,
              finder = 'grep',
              format = 'file',
              show_empty = true,
              supports_live = false,
              layout = 'ivy',
            }
          end,
          desc = '[P]Search for incomplete tasks',
        },
        {
          '<leader>tc',
          function()
            Snacks.picker.grep {
              prompt = ' ',
              search = '^\\s*- \\[x\\] `done:',
              regex = true,
              live = false,
              dirs = { vim.fn.getcwd() },
              args = { '--no-ignore' },
              on_show = function()
                vim.cmd.stopinsert()
              end,
              finder = 'grep',
              format = 'file',
              show_empty = true,
              supports_live = false,
              layout = 'ivy',
            }
          end,
          desc = '[P]Search for complete tasks',
        },
        {
          '<M-b>',
          function()
            Snacks.picker.git_branches {
              layout = 'select',
            }
          end,
          desc = 'Branches',
        },
        {
          '<leader>sk',
          function()
            Snacks.picker.keymaps {
              layout = 'vertical',
            }
          end,
          desc = 'Keymaps',
        },
        {
          '<leader><space>',
          function()
            Snacks.picker.files {
              finder = 'files',
              format = 'file',
              hidden = false,
              show_empty = true,
              supports_live = true,
              layout = 'ivy',
            }
          end,
          desc = 'Find Files',
        },
        {
          '<Tab>',
          function()
            Snacks.picker.buffers {
              on_show = function()
                vim.cmd.stopinsert()
              end,
              finder = 'buffers',
              format = 'buffer',
              hidden = false,
              unloaded = true,
              current = true,
              sort_lastused = true,
              win = {
                input = {
                  keys = { ['d'] = 'bufdelete' },
                },
                list = { keys = { ['d'] = 'bufdelete' } },
              },
              layout = 'vscode',
            }
          end,
          desc = '[P]Snacks picker buffers',
        },
      }
    end,
    opts = {
      picker = {
        transform = function(item)
          if not item.file then
            return item
          end
          if item.file:match 'lazyvim/lua/config/keymaps%.lua' then
            item.score_add = (item.score_add or 0) - 30
          end
          return item
        end,
        debug = { scores = false },
        layout = { preset = 'ivy', cycle = false },
        layouts = {
          ivy = {
            layout = {
              box = 'vertical',
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.5,
              border = 'top',
              title = ' {title} {live} {flags}',
              title_pos = 'left',
              { win = 'input', height = 1, border = 'bottom' },
              {
                box = 'horizontal',
                { win = 'list', border = 'none' },
                { win = 'preview', title = '{preview}', width = 0.5, border = 'left' },
              },
            },
          },
          vscode = {
            layout = {
              backdrop = false,
              width = 0.4,
              height = 0.6,
              align = 'top',
              box = 'vertical',
              border = 'rounded',
              title = '{title} {live} {flags}',
              title_pos = 'center',
              { win = 'input', height = 1, border = 'bottom' },
              {
                box = 'horizontal',
                { win = 'list', border = 'none' },
                { win = 'preview', title = '{preview}', width = 0.5, border = 'left' },
              },
            },
          },
          vertical = {
            layout = {
              backdrop = false,
              width = 0.8,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = 'vertical',
              border = 'rounded',
              title = '{title} {live} {flags}',
              title_pos = 'center',
              { win = 'input', height = 1, border = 'bottom' },
              { win = 'list', border = 'none' },
              { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
            },
          },
        },
        matcher = { frecency = true },
        win = {
          input = {
            keys = {
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
              ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
              ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
              ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
              ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
            },
          },
        },
        formatters = {
          file = {
            filename_first = true,
            truncate = 80,
          },
        },
      },
      signature = { enabled = false },
      hover = { enabled = true },
      lazygit = {
        theme = { selectedLineBgColor = { bg = 'CursorLine' } },
        win = { width = 0, height = 0 },
      },
      notifier = { enabled = true, top_down = false },
      styles = {
        snacks_image = {
          relative = 'editor',
          col = -1,
        },
      },
      image = {
        enabled = true,
        doc = {
          inline = vim.g.neovim_mode == 'skitty' and true or false,
          float = true,
          max_width = vim.g.neovim_mode == 'skitty' and 5 or 60,
          max_height = vim.g.neovim_mode == 'skitty' and 2.5 or 30,
        },
      },
      dashboard = {
        preset = {
          keys = {
            {
              icon = ' ',
              key = 'c',
              desc = 'Config',
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            {
              icon = ' ',
              key = 's',
              desc = 'Restore Session',
              section = 'session',
              action = 'ql',
            },
            { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
          header = [[

▓█████▄ ▓█████ ██▒   █▓   ▓█████▄  ▄▄▄      ▓█████▄ 
▒██▀ ██▌▓█   ▀▓██░   █▒   ▒██▀ ██▌▒████▄    ▒██▀ ██▌
░██   █▌▒███   ▓██  █▒░   ░██   █▌▒██  ▀█▄  ░██   █▌
░▓█▄   ▌▒▓█  ▄  ▒██ █░░   ░▓█▄   ▌░██▄▄▄▄██ ░▓█▄   ▌
░▒████▓ ░▒████▒  ▒▀█░     ░▒████▓  ▓█   ▓██▒░▒████▓ 
 ▒▒▓  ▒ ░░ ▒░ ░  ░ ▐░      ▒▒▓  ▒  ▒▒   ▓▒█░ ▒▒▓  ▒ 
 ░ ▒  ▒  ░ ░  ░  ░ ░░      ░ ▒  ▒   ▒   ▒▒ ░ ░ ▒  ▒ 
 ░ ░  ░    ░       ░░      ░ ░  ░   ░   ▒    ░ ░  ░ 
   ░       ░  ░     ░        ░          ░  ░   ░    
 ░                 ░       ░                 ░      
 [Github@DevDad-Main]
          ]],
        },
      },
    },
  },
}
