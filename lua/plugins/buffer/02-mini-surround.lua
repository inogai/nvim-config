return {
  {
    -- Provide mappings to easily delete, change, add, and find surroundings
    'nvim-mini/mini.surround',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
      custom_surroundings = {
        ['('] = { output = { left = '(', right = ')' } },
      },
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
}
