local prose = require('nvim-prose')

local Prose = {
  condition = prose.is_available,

  update = { 'InsertLeave', 'BufEnter' },

  provider = function() return '󰆙 ' .. prose.word_count() end,
}

return Prose
