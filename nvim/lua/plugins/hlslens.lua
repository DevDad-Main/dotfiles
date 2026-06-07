return {
  "kevinhwang91/nvim-hlslens",
  event = "VeryLazy",
  config = function()
    local function lens(render, pos_list, nearest, wkg_i, _)
      local hl = "Folded"
      local pattern = vim.fn.getreg("/")
      pattern = pattern:gsub("^\\<", ""):gsub("\\>$", "")

      local cur_ratio = "(" .. ("%d/%d"):format(wkg_i, #pos_list) .. ")"
      local chunks = {
        { "   ", "Ignore" },
        { [[  "]], hl },

        { pattern, hl },
        { [[" ]], hl },
        { cur_ratio, hl },
        { " ", hl },
      }

      local lnum, col = pos_list[wkg_i][1], pos_list[wkg_i][2]
      render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end

    require("hlslens").setup({
      calm_down = true,
      enable_incsearch = false,
      override_lens = lens,
    })

    local map = vim.api.nvim_set_keymap
    local kopts = { noremap = true, silent = true }

    map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR>zzzv<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR>zzzv<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map("n", "<Leader>l", "<Cmd>noh<CR>", kopts)
  end,
}
