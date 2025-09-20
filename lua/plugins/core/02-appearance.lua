return {
  {
    -- Icon provider
    'nvim-mini/mini.icons',
    opts = {
      lsp = {
        copilot = { glyph = ' ', hl = 'MiniIconsGrey' },
        avantecmd = { glyph = ' ', hl = 'MiniIconsGreen' },
        avantemention = { glyph = '󰁥 ', hl = 'MiniIconsRed' },
      },
    },
  },
  {
    -- Catppuccin Colorscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1001,
    ---@type CatppuccinOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      flavour = 'auto', -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      custom_highlights = function(C)
        local U = require('catppuccin.utils.colors')
        return {
          -- ['@markup.strong'] = { fg = C.maroon },
          ['@markup.italic'] = { fg = C.blue },
          ['@custom.link.generic'] = { fg = C.sky, style = { 'underdotted' } },
          ['@custom.strong.underdotted'] = { fg = C.maroon, style = { 'bold', 'underdotted' } },
          ['@module'] = { fg = C.peach, style = { 'italic' } },
          ['zshOperator'] = { link = '@operator' },
          ['DiagnosticUnderlineInfo'] = { sp = C.teal, style = { 'undercurl' } },
          ['LspReferenceText'] = { bg = U.darken(C.yellow, 0.4) },
          ['LspReferenceRead'] = { link = 'LspReferenceText' },
          ['LspReferenceWrite'] = { link = 'LspReferenceText' },
          ['LspReferenceTarget'] = { link = 'LspReferenceText' },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
