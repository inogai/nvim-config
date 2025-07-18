---Extra Actions for completion
local M = {}

---Stop active MiniSnippets session
---@return boolean | nil
function M.snippet_clear()
  if require('mini.snippets').session.get() then
    require('mini.snippets').session.stop()
    return true
  end
end

---Accept completion and remove duplicate closing pairs
---@return boolean | nil
function M.select_accept_and_deduplicate()
  local blink = require('blink.cmp')
  local completion_list = require('blink.cmp.completion.list')
  local selected_item = blink.get_selected_item() or completion_list[1]
  local str_utils = require('lib.str-utils')

  return blink.select_and_accept({
    callback = function()
      local textEdit = selected_item and selected_item.textEdit
      if not textEdit then return end

      local end_pos = textEdit.range['end']

      -- Get text after the completion to check for trailing pairs
      local after_text = vim.api.nvim_buf_get_text(
        0,
        end_pos.line,
        end_pos.character,
        end_pos.line,
        end_pos.character + 99,
        {}
      )[1]

      -- Check if the completion text already contains the closing pair
      local match = str_utils.find_longest_prefix_match(textEdit.newText, after_text)
      if not match then return end

      -- Remove the duplicate closing pair
      vim.api.nvim_buf_set_text(
        0,
        end_pos.line,
        end_pos.character,
        end_pos.line,
        end_pos.character + #match,
        { '' }
      )
    end,
  })
end

return M
