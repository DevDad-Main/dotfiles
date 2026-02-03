return {
  "dmtrKovalenko/fff.nvim",
  cmd = "Fff",
  build = "cargo build --release",
  keys = { "<leader>f" },
  config = function()
    require("fff").setup({
      title = "Files",
      prompt = " ",
      lazy_sync = true,
      debug = {
        enabled = true,
        show_scores = true,
      },
      layout = {
        height = 1,
        width = 1,
        prompt_position = "top",
        preview_position = "right",
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
      hl = {
        border = "none",
      },
    })
  end,
}
