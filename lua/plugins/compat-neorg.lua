return {
  {
    '3rd/image.nvim',
    opts = {},
  },

  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = { ensure_installed = { 'norg' } },
  },

  {
    'nvim-neorg/neorg',
    dependencies = { '3rd/image.nvim' },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    --- @module 'neorg'
    --- @type neorg.configuration.user
    opts = {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
      },
    },
  },
}
