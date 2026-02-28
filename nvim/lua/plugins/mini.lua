return {
  "nvim-mini/mini.nvim",
  event = "BufReadPost",
  config = function()
    require("mini.surround").setup()
    require("mini.move").setup()

    require("mini.indentscope").setup({
      -- symbol = "▎",
      symbol = "╎",
      draw = {
        -- To Disbale aniamtions
        animation = require("mini.indentscope").gen_animation.none(),
        delay = 50,
        -- animation = require("mini.indentscope").gen_animation.quadratic({
        --   easing = "out",
        --   duration = 120,
        --   unit = "total",
        -- }),
      },
    })
    -- require("mini.statusline").setup()
  end,
}
