return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    -- ensure that is runs before nvim-treesitter
    priority = 10,
    config = function()
      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require('nvim-treesitter.textobjects.move') ---@type table<string,fun(...)>
      local configs = require('nvim-treesitter.configs')
      for name, fn in pairs(move) do
        if name:find('goto') == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module('textobjects.move')[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find('[%]%[][cC]') then
                  vim.cmd('normal! ' .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'vue', 'svelte', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
    opts = {},
  },

  {
    'echasnovski/mini.ai',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
      n_lines = 500,
    },
  },

  {
    'echasnovski/mini.pairs',
    event = { 'InsertEnter' },
    opts = {
      skip_unbalanced = true,
    },
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
    cmd = { 'Z' },
  },
}
