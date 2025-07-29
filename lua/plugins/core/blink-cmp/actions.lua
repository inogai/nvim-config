---Extra Actions for completion
local M = {}

---Stop active MiniSnippets session
---@return boolean | nil
function M.snippet_clear()
  ---@module 'mini.snippets'
  if MiniSnippets.session.get() then
    vim.schedule(function() MiniSnippets.session.stop() end)
    return true
  end
end

return M
