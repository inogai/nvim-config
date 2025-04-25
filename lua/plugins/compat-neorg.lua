return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = { ensure_installed = { 'norg' } },
  },

  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    --- @module 'neorg'
    --- @type neorg.configuration.user
    opts = {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {
          config = {
            icons = {
              list = {
                icons = { '●', '○', '◆', '◇' },
              },
            },
          },
        },
      },
    },
  },
}
