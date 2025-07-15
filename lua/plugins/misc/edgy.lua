local M = {
  default_command = {
    bottom = function() Snacks.terminal.toggle() end,
  },
}

--- Toggle the windows at the specified position, calling default_command if not
--- exists.
---@param pos 'bottom'
function M.toggle(pos)
  local edgy = require('edgy')

  local win_ids = vim.api.nvim_list_wins()
  local edgy_wins = vim.tbl_map(edgy.get_win, win_ids)
  local pos_wins = vim.tbl_filter(function(it) return it.view.edgebar.pos ~= nil end, edgy_wins)

  if #pos_wins == 0 then
    M.default_command[pos]()
  else
    edgy.toggle(pos)
  end
end

return {
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    opts = {
      animate = { enabled = false },
      bottom = {
        {
          ft = 'snacks_terminal',
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == '' end,
        },
        {
          ft = 'help',
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf) return vim.bo[buf].buftype == 'help' end,
        },
      },
      right = {
        {
          ft = 'iron',
          size = { width = 0.5 },
        },
      },
    },
    keys = {
      { '<C-/>', function() M.toggle('bottom') end, desc = 'Toggle Bottom', mode = { 'n', 'i', 't' } },
    },
  },
}
