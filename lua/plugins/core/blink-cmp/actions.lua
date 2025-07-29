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

return M
