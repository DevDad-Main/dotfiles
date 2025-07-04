-- local devicons = require("nvim-web-devicons")

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "arctic",
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "", right = "" }, right_padding = 2 },
        },
        -- lualine_c = {}, -- Should remove the file path from below
        -- lualine_c = {
        --   {
        --     "filename",
        --     path = 0, -- shows just the filename, no path
        --   },
        -- },
        lualine_c = {
          {
            "filename",
            path = 1,
            --0 – just the filename
            --1 – relative path
            --2 – absolute path
            --3 – absolute path, with ~ for home
            separator = { right = "" },
            right_padding = 0,
          },

          {
            function()
              local fileType = vim.bo.filetype
              local ok, devicons = pcall(require, "nvim-web-devicons")
              local icon = ok and devicons.get_icon_by_filetype(fileType) or nil
              return icon or "" -- fallback icon
            end,
            separator = { left = "", right = "" },
          },
          -- {
          --   function()
          --     -- return vim.bo.filetype
          --     local fileType = vim.bo.filetype
          --     local icon, _ = devicons.get_icon_by_filetype(fileType)
          --     return icon or "" -- fallback icon
          --   end,
          --   separator = { left = "", right = "" },
          --   -- color = { fg = "#000000", bg = "#f38ba8" }, -- or pick your colors
          -- },
        },
        lualine_x = {},
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%R")
            end,
            separator = { left = "", right = "" },
          },
        },
      },
    },
  },
}
