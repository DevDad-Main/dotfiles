return {
  "aznhe21/actions-preview.nvim",
  keys = { "<leader>sa" },
  config = function()
    require("actions-preview").setup({
      backend = { "telescope" },
      telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {}),
    })

    vim.api.nvim_set_hl(0, "TelescopeSelection", {
      link = "@function",
      bold = true,
    })

    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {
      link = "@comment",
    })

    vim.api.nvim_set_hl(0, "TelescopeBorder", {
      link = "@function",
    })
  end,
}
