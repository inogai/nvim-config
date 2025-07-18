local M = {}

---Find the longest substring of pattern that exists at the start of text
---@param text string The text to search in
---@param pattern string The pattern to match against
---@return string | nil The longest matching substring or nil if no match
function M.find_longest_prefix_match(text, pattern)
  for i = #text, 1, -1 do
    local head = pattern:sub(1, i)
    if text:find(head, 1, true) then return head end
  end
  return nil
end

return M
