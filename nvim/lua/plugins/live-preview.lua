return {
  {
    "brianhuster/live-preview.nvim",
    -- dependencies = "ibhagwan/fzf-lua",
    require("livepreview.config").set({
      port = 5500,
      browser = "firefox",
      dynamic_root = false,
      sync_scroll = true,
      picker = "",
    }),
  },
}
