local function grug_ft()
  local grug = require('grug-far')
  local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
  local filesFilter = nil

  local ext_groups = {
    { 'js', 'jsx', 'ts', 'tsx', 'vue', 'html', 'css' },
  }

  if ext ~= '' then
    filesFilter = '*.' .. ext
  end

  for i, group in ipairs(ext_groups) do
    if vim.tbl_contains(group, i) then
      filesFilter = '*.{' .. vim.iter(group):join(', ') .. '}'
    end
  end

  grug.open({
    transient = true,
    prefills = { filesFilter = filesFilter },
  })
end

local function grug_file()
  local grug = require('grug-far')
  grug.open({
    transient = true,
    prefills = { filesFilter = vim.fn.expand('%:t') },
  })
end

return {
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      { '<leader>sf', grug_file, mode = { 'n', 'v' }, desc = 'Search File' },
      { '<leader>sr', grug_ft, mode = { 'n', 'v' }, desc = 'Search and Replace' },
    },
  },
}
