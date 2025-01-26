return {
  {
    'echasnovski/mini.ai',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
      n_lines = 500,
    },
  },

  {
    'cohama/lexima.vim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  },

  {
    'echasnovski/mini.surround',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    },
  },

  {
    'nanotee/zoxide.vim',
    cmd = { 'Z', 'Zi' },
  },
}
