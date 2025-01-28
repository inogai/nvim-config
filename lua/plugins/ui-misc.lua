return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'echasnovski/mini.icons',
    opts = {
      lsp = {
        copilot = { glyph = ' ', hl = 'MiniIconsGrey' },
      },
    },
  },
}
