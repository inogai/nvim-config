---check if the character is a CJK character
---if a string is passed, it will check the first character
---@param char string
local function is_cjk_char(char)
  local c = string.byte(char, 1)
  if c >= 228 and c <= 233 then -- 首字节范围
    local c1 = string.byte(char, 2)
    local c2 = string.byte(char, 3)
    return c1 and c2 and c1 >= 128 and c1 <= 191 and c2 >= 128 and c2 <= 191
  end
  return false
end

local function wordcount()
  local words = 0
  local cjk = 0

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(lines) do
    for word in line:gmatch('%S+') do
      -- if the 1st character is a CJK character, count the whole word
      if is_cjk_char(word) then
        cjk = cjk + vim.fn.strchars(word)
      else
        words = words + 1
      end
    end
  end

  return {
    words = words,
    cjk = cjk,
  }
end

return {
  component = function()
    local filetypes = {
      'markdown',
      'text',
      'norg',
      'typst',
    }

    local template = {
      ['󰆙 '] = 'words',
      ['󱌱 '] = 'cjk',
    }

    return {
      condition = function()
        return vim.tbl_contains(filetypes, vim.bo.filetype)
        --
      end,
      update = { 'BufEnter', 'TextChanged' },
      provider = function()
        local result = wordcount()
        local ret = ' '

        for k, v in pairs(template) do
          local count = result[v]
          if count > 0 then
            ret = ret .. k .. count .. ' '
          end
        end

        return ret
      end,
    }
  end,
}
