return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  config = function()
    require("ufo").setup({
      enable_get_fold_virt_text = true,
      fold_virt_text_handler = function(virtText, _, endLnum, width, truncate, ctx)
        -- NOTE: the original snippet referenced `suffix` without defining it.
        -- This keeps the handler valid while preserving the rest of the logic.
        local suffix = ""
        local filling = table.concat({ " ", tools.ui.icons.ellipses, " " })
        table.insert(virtText, { filling, "Folded" })
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        local endVirtText = ctx.get_fold_virt_text(endLnum)
        for i, chunk in ipairs(endVirtText) do
          local chunkText = chunk[1]
          local hlGroup = chunk[2]
          if i == 1 then
            chunkText = chunkText:gsub("^%s+", "")
          end
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(virtText, { chunkText, hlGroup })
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            table.insert(virtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        return virtText
      end,
      open_fold_hl_timeout = 0,
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })
    -- require("ufo").setup({
    --   close_fold_kinds_for_ft = {
    --     default = { "imports", "comment", "region" },
    --     json = { "array" },
    --     c = { "comment", "region" },
    --     javascript = { "region", "comment" },
    --   },
    --   fold_virt_text_handler = _G.ufo_fold_handler,
    --   open_fold_hl_timeout = 0,
    --   preview = {
    --     win_config = {
    --       border = "rounded",
    --       winblend = 15,
    --     },
    --   },
    --   provider_selector = function(_, filetype, buftype)
    --     if filetype == "markdown" then
    --       return ""
    --     end
    --
    --     local function handleFallbackException(bufnr, err, providerName)
    --       if type(err) == "string" and err:match("UfoFallbackException") then
    --         return require("ufo").getFolds(bufnr, providerName)
    --       else
    --         return require("promise").reject(err)
    --       end
    --     end
    --
    --     return (filetype == "" or buftype == "nofile") and "indent"
    --       or function(bufnr)
    --         return require("ufo")
    --           .getFolds(bufnr, "lsp")
    --           :catch(function(err)
    --             return handleFallbackException(bufnr, err, "treesitter")
    --           end)
    --           :catch(function(err)
    --             return handleFallbackException(bufnr, err, "indent")
    --           end)
    --       end
    --   end,
    -- })
  end,
}
