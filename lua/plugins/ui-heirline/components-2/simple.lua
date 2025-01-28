local M = {}

---@param width integer | 'grow'
function M.Hspace(width)
  if width == 'grow' then
    return { provider = '%=' }
  else
    return { provider = (' '):rep(width) }
  end
end

function M.FileIcon()
  local icon = '󰈔'
  local color = nil
  return {
    updates = { 'BufEnter', 'BufWritePost', 'FileChangedShellPost' },
    init = function()
      local filename = vim.fn.expand('%:t')
      local _icon, hl = require('mini.icons').get('file', filename)
      icon = _icon
      color = vim.api.nvim_get_hl(0, { name = hl, link = false }).fg
    end,
    provider = function() return icon .. ' ' end,
    hl = function() return { fg = color } end,
  }
end

function M.FileFlags()
  return {
    {
      condition = function() return vim.bo.modified end,
      provider = '[+]',
      hl = { fg = 'green' },
    },
    {
      condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
      provider = '',
      hl = { fg = 'orange' },
    },
  }
end

function M.FileFormat()
  return {
    updates = { 'BufEnter', 'BufWritePost', 'FileChangedShellPost' },
    provider = function()
      local fmt = vim.bo.fileformat
      return fmt
    end,
  }
end

function M.Ruler()
  return {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = '%7(%l/%03L%):%02c %P',
  }
end

return M
