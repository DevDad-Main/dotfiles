require("mini.files").setup({
  mappings = {
    close = "q",
    -- Use this if you want to open several files
    go_in = "l",
    -- This opens the file, but quits out of mini.files (default L)
    go_in_plus = "<CR>",
    -- I swapped the following 2 (default go_out: h)
    -- go_out_plus: when you go out, it shows you only 1 item to the right
    -- go_out: shows you all the items to the right
    go_out = "H",
    go_out_plus = "h",
    -- Default <BS>
    reset = "<BS>",
    -- Default @
    reveal_cwd = ".",
    show_help = "g?",
    -- Default =
    synchronize = "s",
    trim_left = "<",
    trim_right = ">",
  },
  windows = {
    preview = true,
    width_preview = 60,
    width_focus = 40,
    -- Width of non-focused window
    width_nofocus = 30,
  },
})
