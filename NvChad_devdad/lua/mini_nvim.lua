local M = {}

M.pairs = {
  mappings = {
    ["<"] = { action = "closeopen", pair = "<>", neigh_pattern = "[^\\].", register = { cr = false } },
  },
}

M.files = {
  use_as_default_explorer = true,
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
    max_number = math.huge,
    preview = true,
    width_focus = 30,
    width_nofocus = 20,
    -- width_preview = 25,
    width_preview = 60,
  },
}

local hipatterns = require "mini.hipatterns"
M.hipatterns = {
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
}

M.bufremove = {
  silent = true,
}

M.comment = {}

M.pick = {
  options = {
    use_cache = true,
  },
  mappings = {
    caret_left = "<Left>",
    caret_right = "<Right>",

    choose = "<CR>",
    choose_in_split = "<C-s>",
    choose_in_tabpage = "<C-t>",
    choose_in_vsplit = "<C-v>",
    choose_marked = "<M-CR>",

    delete_char = "<BS>",
    delete_char_right = "<Del>",
    delete_left = "<C-u>",
    delete_word = "<C-w>",

    mark = "<C-x>",
    mark_all = "<C-a>",

    move_down = "<C-j>",
    move_start = "<C-g>",
    move_up = "<C-k>",

    paste = "<C-r>",

    refine = "<C-Space>",
    refine_marked = "<M-Space>",

    scroll_down = "<C-f>",
    scroll_left = "<C-h>",
    scroll_right = "<C-l>",
    scroll_up = "<C-b>",

    stop = "<Esc>",

    toggle_info = "<S-Tab>",
    toggle_preview = "<Tab>",
  },
}

M.move = {
  mappings = {
    line_left = "<A-h>",
    line_right = "<A-l>",
    line_down = "<A-j>",
    line_up = "<A-k>",
  },
}

-- M.indentscope = {
--   symbol = "┋",
-- }

M.ai = {}

M.visits = {
  store = {
    path = vim.fn.stdpath "cache" .. "mini-visits-index",
  },
}

local miniclue = require "mini.clue"
M.clue = {
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },

    { mode = "i", keys = "<C-x>" },

    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },

    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },

    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },

    { mode = "n", keys = "<C-w>" },

    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
  },

  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
}

M.git = {}

M.diff = {
  view = {
    style = "sign",
    signs = { add = " ", change = " ", delete = "" },
  },
}

local starter = require "mini.starter"

M.starter = {
  evaluate_single = false,
  query_updaters = "fqblerg",
  -- header = table.concat({
  --   "                                   ",
  --   "                                   ",
  --   "                                   ",
  --   "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
  --   "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
  --   "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
  --   "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
  --   "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
  --   "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
  --   "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
  --   " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
  --   " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
  --   "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
  --   "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
  --   "                                   ",
  -- }, "\n"),
  footer = os.date "%B %d, %I:%M %p",
  items = {
    {
      name = "f Find Files",
      action = "lua MiniPick.builtin.files()",
      section = " Actions ",
    },
    {
      name = "g LazyGit",
      action = "lua Snacks.lazygit.open()",
      section = " Actions ",
    },
    {
      name = "b Bookmarked Files",
      action = "lua MiniExtra.pickers.visit_paths { filter = 'todo' }",
      section = " Actions ",
    },
    {
      name = "l Lazy Update",
      action = ":Lazy update",
      section = " Actions ",
    },
    {
      name = "e Open Blank File",
      action = ":enew",
      section = " Actions ",
    },
    {
      name = "r Recent Files",
      action = "lua MiniExtra.pickers.oldfiles()",
      section = " Actions ",
    },
    {
      name = "q Quit",
      action = ":q!",
      section = " Actions ",
    },
  },
  content_hooks = {
    starter.gen_hook.aligning("center", "center"),
    function(content)
      -- Filter out any duplicate items
      local seen = {}
      local filtered = {}
      for _, line in ipairs(content) do
        local line_items = {}
        for _, unit in ipairs(line) do
          if unit.type == "item" and unit.item then
            local key = unit.item.name .. unit.item.action
            if not seen[key] then
              seen[key] = true
              table.insert(line_items, unit)
            end
          else
            table.insert(line_items, unit)
          end
        end
        if #line_items > 0 then
          table.insert(filtered, line_items)
        end
      end
      return filtered
    end,
  },
}

M.icons = {
  lsp = {
    ["function"] = { glyph = "󰡱", hl = "MiniIconsCyan" },
  },
}

M.operators = {}

return M
