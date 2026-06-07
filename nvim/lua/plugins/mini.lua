return {
  "nvim-mini/mini.nvim",
  event = "BufReadPost",
  config = function()
    require("mini.surround").setup()
    require("mini.move").setup()
    require("mini.icons").setup()

    -- require("mini.indentscope").setup({
    --   -- symbol = "▎",
    --   symbol = "╎",
    --   draw = {
    --     -- To Disbale aniamtions
    --     animation = require("mini.indentscope").gen_animation.none(),
    --     delay = 50,
    --     -- animation = require("mini.indentscope").gen_animation.quadratic({
    --     --   easing = "out",
    --     --   duration = 120,
    --     --   unit = "total",
    --     -- }),
    --   },
    -- })
    -- require("mini.pairs").setup({
    --   modes = { insert = true, command = true, terminal = false },
    --   -- skip autopair when next character is one of these
    --   skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    --   -- skip autopair when the cursor is inside these treesitter nodes
    --   skip_ts = { "string" },
    --   -- skip autopair when next character is closing pair
    --   -- and there are more closing pairs than opening pairs
    --   skip_unbalanced = true,
    --   -- better deal with markdown code blocks
    --   markdown = true,
    -- })
  end,
}
