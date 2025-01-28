local function grug_ft()
  local grug = require('grug-far')
  local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
  local filesFilter = nil

  if not ext or ext == '' then
  elseif ext == 'js' or ext == 'ts' then
    filesFilter = '*.(j|t)sx?,*.vue'
  else
    filesFilter = '*.' .. ext
  end

  grug.with_visual_selection({
    transient = true,
    prefills = { filesFilter = filesFilter },
  })
end

local function grug_file()
  local grug = require('grug-far')
  grug.with_visual_selection({
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
