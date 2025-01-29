-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- vim.api.nvim_create_autocmd('BufDelete', {
--   desc = 'Open Dashboard on last buffer delete',
--   pattern = '*',
--   group = vim.api.nvim_create_augroup('user-bufdelete', { clear = true }),
--   callback = function()
--     if vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == '' then
--       vim.cmd('Dashboard')
--     end
--   end,
-- })

require('config.autocmds.root')
