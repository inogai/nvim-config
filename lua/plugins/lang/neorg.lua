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
        ['core.esupports.hop'] = {},
        ['core.keybinds'] = {
          config = {
            default_keybinds = true,
          },
        },
        ['core.highlights'] = {
          config = {
            highlights = {
              links = {
                location = {
                  generic = '+@custom.link.generic',
                  definition = '+@custom.strong.underdotted',
                },
              },
            },
          },
        },
        ['core.integrations.image'] = {},
      },
    },
    keys = {
      { '<localleader>id', '<Plug>(neorg.tempus.insert-date)', desc = '[I]nsert [D]ate', ft = 'norg' },
      { 'gd', '<Plug>(neorg.esupports.hop.hop-link)', desc = '[Neorg] Hop Link', ft = 'norg' },
    },
  },
}
