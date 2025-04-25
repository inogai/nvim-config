local M = {}

function M.stage_hunk() require('gitsigns').stage_hunk() end

function M.stage_visual()
  local first_line = vim.fn.line('v')
  local last_line = vim.fn.line('.')
  require('gitsigns').stage_hunk({ first_line, last_line })
  print('Staged ' .. (last_line - first_line + 1) .. ' lines')
end

function M.reset_visual()
  local first_line = vim.fn.line('v')
  local last_line = vim.fn.line('.')
  require('gitsigns').reset_hunk({ first_line, last_line })
  print('Reset' .. (last_line - first_line + 1) .. ' lines')
end

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
    },
    keys = {
      { ']c', function() require('gitsigns').nav_hunk('next') end, desc = 'Next Hunk' },
      { '[c', function() require('gitsigns').nav_hunk('prev') end, desc = 'Prev Hunk' },
      { 'gh', M.stage_visual, desc = 'Stage Line' },
      { 'gh', M.stage_visual, desc = 'Stage Visual', mode = 'v' },
      { 'gH', M.reset_visual, desc = 'Reset Line' },
      { 'gH', M.reset_visual, desc = 'Reset Visual', mode = 'v' },
      { 'gp', function() require('gitsigns').preview_hunk() end, desc = 'Preview Hunk' },
      { 'go', function() require('gitsigns').preview_hunk_inline() end, desc = 'Preview Hunk Inline' },
    },
  },
}
