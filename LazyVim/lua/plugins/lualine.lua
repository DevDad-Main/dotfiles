-- local devicons = require("nvim-web-devicons")
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
-- return {}
return {
  "nvim-lualine/lualine.nvim",
  enabled = false, -- Uncommment this to disable lualine plugin
  config = function()
    -- Color table for highlights
    local colors = {
      bg = "#202328",
      fg = "#bbc2cf",
      yellow = "#ECBE7B",
      cyan = "#008080",
      darkblue = "#081633",
      green = "#98be65",
      orange = "#FF8800",
      violet = "#a9a1e1",
      magenta = "#c678dd",
      blue = "#51afef",
      red = "#ec5f67",
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left({
      function()
        return "💩"
      end,
      color = function()
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [""] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    })

    ins_left({
      "filename",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = "bold" },
    })

    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
      },
    })

    ins_left({
      function()
        return "%="
      end,
    })

    ins_left({
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = " LSP:",
      color = { fg = "#ffffff", gui = "bold" },
    })

    ins_right({
      "branch",
      icon = " ",
      color = { fg = colors.violet, gui = "bold" },
    })

    ins_right({
      "diff",
      symbols = { added = " ", modified = "󰝤 ", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    require("lualine").setup(config)
  end,
}
-- return {
-- {
--   "nvim-lualine/lualine.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   opts = {
--     options = {
--       theme = "arctic",
--       component_separators = "",
--       section_separators = { left = "", right = "" },
--     },
--     sections = {
--       lualine_a = {
--         { "mode", separator = { left = "", right = "" }, right_padding = 2 },
--       },
--       -- lualine_c = {}, -- Should remove the file path from below
--       -- lualine_c = {
--       --   {
--       --     "filename",
--       --     path = 0, -- shows just the filename, no path
--       --   },
--       -- },
--       lualine_c = {
--         {
--           "filename",
--           path = 1,
--           --0 – just the filename
--           --1 – relative path
--           --2 – absolute path
--           --3 – absolute path, with ~ for home
--           separator = { right = "" },
--           right_padding = 0,
--         },
--
--         {
--            separator = { left = "", right = "" },
--         },
--         -- {
--         --   function()
--         --     -- return vim.bo.filetype
--         --     local fileType = vim.bo.filetype
--         --     local icon, _ = devicons.get_icon_by_filetype(fileType)
--         --     return icon or "" -- fallback icon
--         --   end,
--         --   separator = { left = "", right = "" },
--         --   -- color = { fg = "#000000", bg = "#f38ba8" }, -- or pick your colors
--         -- },
--       },
--       lualine_x = {},
--       lualine_y = {
--         { "progress", separator = " ", padding = { left = 1, right = 0 } },
--         { "location", padding = { left = 0, right = 1 } },
--       },
--       lualine_z = {
--         {
--           function()
--             return " " .. os.date("%R")
--           end,
--           separator = { left = "", right = "" },
--         },
--       },
--     },
--   },
-- },
-- }
