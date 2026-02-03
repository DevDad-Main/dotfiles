return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "julianolf/nvim-dap-lldb",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    { "<Leader>nd", ":DapNew<CR>" },
    { "<C-b>", ":DapToggleBreakpoint<CR>", mode = { "n", "i" } },
  },
  config = function()
    require("dap-lldb").setup()
    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}