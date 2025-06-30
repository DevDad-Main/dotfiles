return {
  {
    --[[
    In Typr window:
      s = toggle symbols
      n = toggle numbers
      r = toggle random
      3 = set 3 lines , and so on!

    In Typrstats vertical window
      D = dashboard
      H = history
      K = Keystrokes
    --]]
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
}
