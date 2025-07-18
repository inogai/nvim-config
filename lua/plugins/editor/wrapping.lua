vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'text',
  callback = function()
    vim.notify('Wrapwidth 80')
    vim.cmd('Wrapwidth 80')
  end,
})

return {
  {
    -- provides cursor wrapping functionality
    'andrewferrier/wrapping.nvim',
    opts = {},
  },
  {
    -- provides forced hard-wrapping of text
    'rickhowe/wrapwidth',
  },
}
