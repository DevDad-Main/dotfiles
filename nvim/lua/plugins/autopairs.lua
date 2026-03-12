return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  enabled = false,
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,
      enable_check_bracket_line = false,
    })
  end,
}
