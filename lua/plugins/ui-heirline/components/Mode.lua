local symbols = require('plugins.ui-heirline.symbols')

---@alias mode "NORMAL" | "O-PENDING" | "VISUAL" | "V-LINE" | "V-BLOCK" | "SELECT" | "S-LINE" | "S-BLOCK" | "INSERT" | "REPLACE" | "V-REPLACE" | "COMMAND" | "EX" | "MORE" | "CONFIRM" | "SHELL" | "TERMINAL"

-- borrowed from lualine
local mode_map = {
  ['n'] = 'NORMAL',
  ['no'] = 'O-PENDING',
  ['nov'] = 'O-PENDING',
  ['noV'] = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['nt'] = 'N-TERMINAL',
  ['ntT'] = 'N-TERMINAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['Vs'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['\22s'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rx'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rvc'] = 'V-REPLACE',
  ['Rvx'] = 'V-REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

---@class ColorMapItem
---@field [1] string - the mode prefix
---@field [2] HeirlineHighlight

--- The `color_map` is a ordered list of mode to color mappings.
--- the first match is used.
---@type table<number, ColorMapItem>>
local color_map = {
  { 'no', { fg = 'bg1', bg = 'orange' } },
  { 'nt', { fg = 'bg1', bg = 'orange' } },
  { 'n', { fg = 'fg3', bg = 'bg1' } },
  { 'i', { fg = 'bg1', bg = 'green' } },
  { 'v', { fg = 'bg1', bg = 'purple' } },
  { 'c', { fg = 'bg1', bg = 'yellow' } },
  { 't', { fg = 'bg1', bg = 'purple' } },
  { '', { fg = 'bg1', bg = 'red' } },
}

---@param mode string
---@return HeirlineHighlight
local color_map_lookup = function(mode)
  for _, v in pairs(color_map) do
    if v[1] == mode then
      return v[2]
    end
  end

  -- fallback to the last item if no matches
  return color_map[#color_map][2]
end

---@module "heirline"

---@class MyHeirline.ModeComponentSelf
---@field mode mode
---@field _hl HeirlineHighlight

local Mode = {
  ---@param self MyHeirline.ModeComponentSelf
  init = function(self) self.mode = vim.fn.mode(1) end,

  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function() vim.cmd('redrawstatus') end),
  },

  ---@param self MyHeirline.ModeComponentSelf
  hl = function(self)
    self._hl = color_map_lookup(self.mode)
    return self._hl
  end,

  {
    ---@param self MyHeirline.ModeComponentSelf
    hl = function(self) return { fg = self._hl.bg, bg = 'bg1' } end,
    provider = symbols.LHC,
  },

  {
    ---@param self MyHeirline.ModeComponentSelf
    provider = function(self)
      if mode_map[self.mode] == 'NORMAL' then
        return symbols.PIN .. ' '
      end
      return symbols.PIN .. ' ' .. mode_map[self.mode] or self.mode
    end,
  },

  {
    ---@param self MyHeirline.ModeComponentSelf
    hl = function(self) return { fg = self._hl.bg, bg = 'bg1' } end,
    provider = function(self)
      if mode_map[self.mode] == 'NORMAL' then
        return ''
      end
      return symbols.RHC
    end,
  },
}

return Mode
