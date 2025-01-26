local conditions = require('heirline.conditions')
local icons = require('config.icons')

local Diagnostics = {
  condition = conditions.has_diagnostics,

  static = {
    error_icon = icons.diagnostics.Error,
    warn_icon = icons.diagnostics.Warn,
    info_icon = icons.diagnostics.Info,
    hint_icon = icons.diagnostics.Hint,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  hl = { bg = 'bg1' },

  update = { 'BufEnter', 'TextChanged' },

  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      if self.errors > 0 then
        return table.concat({ self.error_icon, self.errors, ' ' })
      end
    end,
    hl = { fg = 'diag_error' },
  },

  {
    provider = function(self)
      if self.warnings > 0 then
        return table.concat({ self.warn_icon, self.warnings, ' ' })
      end
    end,
    hl = { fg = 'diag_warn' },
  },

  {
    provider = function(self)
      if self.info > 0 then
        return table.concat({ self.info_icon, self.info, ' ' })
      end
    end,
    hl = { fg = 'diag_info' },
  },

  {
    provider = function(self)
      if self.hints > 0 then
        return table.concat({ self.hint_icon, self.hints, ' ' })
      end
    end,
    hl = { fg = 'diag_hint' },
  },
}

return Diagnostics
