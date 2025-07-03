local _wrap = nil

vim.api.nvim_create_autocmd('User', {
  pattern = 'GoyoEnter',
  callback = function()
    _wrap = vim.wo.wrap --
    vim.wo.wrap = true
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'GoyoLeave',
  callback = function()
    if _wrap ~= nil then
      vim.wo.wrap = _wrap
      _wrap = nil
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'PersistenceSavePre',
  callback = function()
    vim.cmd('Goyo!') --
  end,
})

return {
  { 'junegunn/goyo.vim' },
}
