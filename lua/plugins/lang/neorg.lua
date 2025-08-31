return {
  Utils.ts_ensure_installed({ 'norg' }),

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
              headings = {
                ['1'] = '+@markup.heading.1.markdown',
                ['2'] = '+@markup.heading.2.markdown',
                ['3'] = '+@markup.heading.3.markdown',
                ['4'] = '+@markup.heading.4.markdown',
                ['5'] = '+@markup.heading.5.markdown',
                ['6'] = '+@markup.heading.6.markdown',
              },
            },
          },
        },
        -- ['core.integrations.image'] = {},
      },
    },
    keys = {
      { '<localleader>id', '<Plug>(neorg.tempus.insert-date)', desc = '[I]nsert [D]ate', ft = 'norg' },
      { 'gd', '<Plug>(neorg.esupports.hop.hop-link)', desc = '[Neorg] Hop Link', ft = 'norg' },
    },
  },
}
