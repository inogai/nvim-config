local M = {}

--- @param name string
function M.get_highlight(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })

  local ret = {
    fg = hl.fg,
    bg = hl.bg,
    hl_group = hl,
  }

  if hl.reverse then
    ret.fg, ret.bg = ret.bg, ret.fg
  end

  return ret
end

function M.setup_colors()
  local ret = {
    fg = M.get_highlight('Normal').fg,
    bg = M.get_highlight('Normal').bg,

    bg1 = M.get_highlight('StatusLine').bg,
    fg1 = M.get_highlight('Normal').fg,

    fg3 = M.get_highlight('StatusLine').fg,

    bright_bg = M.get_highlight('Folded').bg,
    bright_fg = M.get_highlight('Folded').fg,
    gray = M.get_highlight('NonText').fg,

    dark_red = vim.g.terminal_color_1 or M.get_highlight('DiffDelete').fg,
    red = vim.g.terminal_color_9 or M.get_highlight('DiagnosticError').fg,
    green = vim.g.terminal_color_10 or M.get_highlight('string').fg,
    yellow = vim.g.terminal_color_11 or M.get_highlight('DiagnosticWarn').fg,
    blue = vim.g.terminal_color_12 or M.get_highlight('Directory').fg,
    purple = vim.g.terminal_color_13 or M.get_highlight('Statement').fg,
    cyan = vim.g.terminal_color_14 or M.get_highlight('Special').fg,
    orange = M.get_highlight('GruvboxOrange').fg or M.get_highlight('Type').fg,

    diag_warn = M.get_highlight('DiagnosticWarn').fg,
    diag_error = M.get_highlight('DiagnosticError').fg,
    diag_hint = M.get_highlight('DiagnosticHint').fg,
    diag_info = M.get_highlight('DiagnosticInfo').fg,
    git_del = M.get_highlight('DiffDelete').fg,
    git_add = M.get_highlight('DiffAdd').fg,
    git_change = M.get_highlight('DiffChange').fg,
  }

  -- Force disable gui options, like reverse
  vim.api.nvim_set_hl(0, 'StatusLine', {
    fg = ret.fg3,
    bg = ret.bg1,
  })

  return ret
end

---@param name string
function M.load_component(name)
  ---@type Heir2.ComponentSpec
  local spec = require('plugins.ui-heirline.components-2.' .. name)

  if spec.plugins then
    vim.list_extend(M.plugins, spec.plugins)
  end

  return spec.component
end

M.plugins = {}

local Navic = M.load_component('navic')
local WordCount = M.load_component('wordcount')

return {
  unpack(M.plugins),
  {
    'rebelot/heirline.nvim',
    opts = function()
      local utils = require('heirline.utils')
      local conditions = require('heirline.conditions')

      local S = require('plugins.ui-heirline.components-2.simple')

      utils.on_colorscheme(M.setup_colors)

      vim.api.nvim_create_augroup('Heirline', { clear = true })

      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function() utils.on_colorscheme(M.setup_colors) end,
        group = 'Heirline',
      })

      vim.api.nvim_create_autocmd('OptionSet', {
        pattern = 'background',
        callback = function() utils.on_colorscheme(M.setup_colors) end,
        group = 'Heirline',
      })

      ---@param component string
      local function h(component) return require('plugins.ui-heirline.components.' .. component) end

      local StatusLine = {
        h('Mode'),
        S.Hspace(1),

        S.FileIcon(),
        S.FileFlags(),
        h('Filename'),
        S.Hspace(1),

        h('Diagnostics'),

        S.Hspace('grow'),

        S.FileFormat(),

        WordCount(),
        S.Hspace(1),

        S.Ruler(),
      }

      local Winbar = {
        S.Hspace(7),
        Navic(),
      }

      local opts = {
        opts = {
          disable_winbar_cb = function(args)
            return conditions.buffer_matches({
              buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal' },
              filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard' },
            }, args.buf)
          end,
        },

        statusline = StatusLine,
        winbar = Winbar,
        tabline = nil,
        statuscolumn = nil,
      }

      return opts
    end,
  },
}
