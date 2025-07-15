vim.o.foldcolumn = '0' -- hide fold column
vim.o.foldlevel = 99 -- Using ufo provider need a large value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

return {
  {
    'kevinhwang91/nvim-ufo',
    lazy = false,
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {},
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },

      {
        'K',
        function()
          local win_id = require('ufo').peekFoldedLinesUnderCursor()
          if not win_id then
            vim.lsp.buf.hover()
          end
        end,
        desc = 'Hover',
      },
    },
  },
}
