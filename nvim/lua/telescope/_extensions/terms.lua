local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local make_entry = require "telescope.make_entry"
local action_state = require "telescope.actions.state"

local get_term_buffers = function()
  local bufs = vim.api.nvim_list_bufs()
  local result = {}
  for _, buf in ipairs(bufs) do
    if vim.bo[buf].buftype == "terminal" then
      table.insert(result, buf)
    end
  end
  return result
end

local function pick_terms()
  local buffers = get_term_buffers()

  if #buffers == 0 then
    print "No terminal buffers open!"
    return
  end

  local bufnrs = buffers
  local opts = { bufnr_width = math.max(unpack(bufnrs)) }

  local results = {}
  for _, buf in ipairs(bufnrs) do
    local element = { bufnr = buf, flag = "", info = vim.fn.getbufinfo(buf)[1] }
    table.insert(results, element)
  end

  local picker = pickers.new {
    prompt_title = " Terminals",
    previewer = conf.grep_previewer(opts),
    finder = finders.new_table {
      results = results,
      entry_maker = make_entry.gen_from_buffer(opts),
    },
    sorter = conf.generic_sorter(),

    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if vim.fn.bufwinid(entry.bufnr) == -1 then
          vim.api.nvim_set_current_buf(entry.bufnr)
        end
      end)
      return true
    end,
  }

  picker:find()
end

return require("telescope").register_extension {
  exports = { terms = pick_terms },
}
