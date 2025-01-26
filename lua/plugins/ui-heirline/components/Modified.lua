local ModifiedIndicator = {
  condition = function() return vim.bo.modifiable and vim.bo.modified end,
  update = { 'BufEnter', 'TextChanged', 'TextChangedI', 'BufWritePost' },
  provider = '*',
}

return ModifiedIndicator
