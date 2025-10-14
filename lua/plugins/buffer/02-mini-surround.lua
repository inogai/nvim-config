return {
  {
    -- Provide mappings to easily delete, change, add, and find surroundings
    'inogai/mini.surround',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
      visualize_delete = true,
      mappings = {
        add = 'ga', -- Add surrounding in Normal and Visual modes
        delete = 'gs', -- Delete surrounding
        replace = 'ge', -- Replace surrounding

        -- find = 'sf', -- Find surrounding (to the right)
        -- find_left = 'sF', -- Find surrounding (to the left)
        -- highlight = 'sh', -- Highlight surrounding
        -- update_n_lines = 'sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    },
  },
}
