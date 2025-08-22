return {
  {
    'inogai/moegi.nvim',
    lazy = false,
    dependencies = {
      'rktjmp/lush.nvim',
    },
    -- priority = 1001,
    -- config = function() vim.cmd([[colorscheme moegi]]) end,
  },
  {
    'folke/tokyonight.nvim',
  },
  {
    'ellisonleao/gruvbox.nvim',
  },
  {
    'rebelot/kanagawa.nvim',
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1001,
    opts = {
      flavour = 'auto', -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      custom_highlights = function(C)
        return {
          -- ['@markup.strong'] = { fg = C.maroon },
          ['@markup.italic'] = { fg = C.blue },
          ['@custom.link.generic'] = { fg = C.sky, style = { 'underdotted' } },
          ['@custom.strong.underdotted'] = { fg = C.maroon, style = { 'bold', 'underdotted' } },
          ['@module'] = { fg = C.peach, style = { 'italic' } },
          ['zshOperator'] = { link = '@operator' },
          ['DiagnosticUnderlineInfo'] = { sp = C.teal, style = { 'undercurl' } },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
