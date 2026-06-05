return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "VeryLazy" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "typescript", "tsx", "javascript", "lua", "json", "prisma", "java" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
  opts = {
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
          ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
          ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
          ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
          ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
          ["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
          ["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>sp"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>sP"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]s"] = "@block.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]S"] = "@block.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[s"] = "@block.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[S"] = "@block.outer",
        },
      },
    },
  },
}
