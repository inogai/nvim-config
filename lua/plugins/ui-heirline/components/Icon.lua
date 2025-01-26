---@class MyHeirline.Icon.Self
---@field _icon_str string
---@field _icon_color string

---@type MyHeirline.Unit<MyHeirline.Icon.Self>
local Icon = {
  init = function(self)
    if not vim.bo.modifiable or vim.bo.readonly then
      self._icon_str = ''
      self._icon_color = 'fg3'
    else
      local filename = vim.fn.expand('%:t')
      local icon, hl, is_default = require('mini.icons').get('file', filename)

      self._icon_str = icon
      self._icon_color = vim.api.nvim_get_hl(0, { name = hl, link = false }).fg
    end
  end,

  hl = function(self) return { fg = self._icon_color, bg = 'bg1' } end,

  provider = function(self) return self._icon_str .. ' ' end,
}

return Icon
