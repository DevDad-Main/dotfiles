return {
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require 'notify'
      notify.setup {
        render = 'compact',
        stages = 'fade_in_slide_out', -- smoother animation (optional)
        timeout = 3000, -- time in ms before notification disappears
      }

      -- Override vim.notify with nvim-notify
      vim.notify = notify
    end,
  },
}
