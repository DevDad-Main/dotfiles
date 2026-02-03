return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  config = function()
    require("ufo").setup({
      close_fold_kinds_for_ft = {
        default = { "imports", "comment", "region" },
        json = { "array" },
        c = { "comment", "region" },
        javascript = { "region", "comment" },
      },
      fold_virt_text_handler = _G.ufo_fold_handler,
      open_fold_hl_timeout = 0,
      preview = {
        win_config = {
          border = "rounded",
          winblend = 15,
        },
      },
      provider_selector = function(_, filetype, buftype)
        if filetype == "markdown" then
          return ""
        end

        local function handleFallbackException(bufnr, err, providerName)
          if type(err) == "string" and err:match("UfoFallbackException") then
            return require("ufo").getFolds(bufnr, providerName)
          else
            return require("promise").reject(err)
          end
        end

        return (filetype == "" or buftype == "nofile") and "indent"
          or function(bufnr)
            return require("ufo")
              .getFolds(bufnr, "lsp")
              :catch(function(err)
                return handleFallbackException(bufnr, err, "treesitter")
              end)
              :catch(function(err)
                return handleFallbackException(bufnr, err, "indent")
              end)
          end
      end,
    })
  end,
}