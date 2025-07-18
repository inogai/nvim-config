-- git integration
require('plugins.editor.mini-files.git-integration')

local M = require('plugins.editor.mini-files.mf-utils')

return {
  {
    'echasnovski/mini.files',
    lazy = false,
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      mappings = {
        toggle_hidden = 'g.',
        reveal_cwd = '',
        change_cwd = 'gc',
        go_in_horizontal = '<C-w>s',
        go_in_vertical = '<C-w>v',
        go_in_horizontal_plus = '<C-w>S',
        go_in_vertical_plus = '<C-w>V',
        synchronize = ';',
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      { '<leader>e', M.toggle_at_root, desc = 'Files' },
    },
  },
}
