return {
  "rrethy/vim-illuminate",
  config = function()
    require("illuminate").configure({
      delay = 350,
      filetypes_denylist = {
        "aerial",
        "neo-tree",
      },
      modes_denylist = { "v", "V" },
      under_cursor = false,
    })
  end,
}
