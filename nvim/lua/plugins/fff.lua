return {
  "dmtrKovalenko/fff.nvim",
  -- this will download prebuild binary or try to use existing rustup toolchain to build from source
  -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
  build = ":lua require('fff.download').download_or_build_binary() ",
  config = function()
    require("fff").setup({
      title = "Files",
      prompt = " ",
      lazy_sync = true,
      debug = {
        enabled = false,
        show_scores = true,
      },
      layout = {
        height = 1,
        width = 1,
        -- height = function(_terminal_width, terminal_height)
        --   return 28 / terminal_height
        -- end,
        -- width = function(terminal_width, _terminal_height)
        --   return 98 / terminal_width
        -- end,
        prompt_position = "top",
        preview_position = "right",
        -- preview_position = "bottom",
        preview_size = 0.4,
        show_scrollbar = false,
      },
      keymaps = {
        close = "<Esc>",
        select = "<CR>",
        select_split = "<C-s>",
        select_vsplit = "<C-v>",
        select_tab = "<C-t>",
        move_up = { "<Up>", "<C-p>", "<C-k>" },
        move_down = { "<Down>", "<C-n>", "<C-j>" },
        preview_scroll_up = "<C-u>",
        preview_scroll_down = "<C-d>",
        toggle_debug = "<F2>",
        cycle_previous_query = "<C-Up>",
        toggle_select = "<Tab>",
        send_to_quickfix = "<C-q>",
      },
      -- 👇 Add these two sections
      history = {
        enabled = true, -- enables recent file tracking
        max_items = 100,
      },

      git = {
        enabled = true, -- enables git status signs (green/red bars)
      },
    })
  end,
}
