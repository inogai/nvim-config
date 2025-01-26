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
      local ext = vim.fn.expand('%:e')
      self._icon_str, self._icon_color = require('nvim-web-devicons').get_icon_color(filename, ext, { default = true })
    end
  end,

  hl = function(self) return { fg = self._icon_color, bg = 'bg1' } end,

  provider = function(self) return self._icon_str .. ' ' end,
}

return Icon
