local path_to_my_vault = vim.fn.expand('~') .. '/Documents/Obsidian'

return {
  {
    -- This plugin provides integration between Neovim and Obsidian.md
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    event = {
      'BufReadPre ' .. path_to_my_vault .. '/*.md',
      'BufNewFile ' .. path_to_my_vault .. '/*.md',
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      ui = { enable = false }, -- in flavour of render-markdown.nvim
      workspaces = {
        {
          name = 'v2',
          path = path_to_my_vault .. '/v2',
        },
      },
    },
  },
}
