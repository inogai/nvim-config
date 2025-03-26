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
    config = function() vim.cmd([[colorscheme catppuccin]]) end,
  },
}
