return {
  {
    'inogai/moegi.nvim',
    lazy = false,
    dependencies = {
      'rktjmp/lush.nvim',
    },
    priority = 1001,
    config = function() vim.cmd([[colorscheme moegi]]) end,
    dev = true,
  },
  {
    'folke/tokyonight.nvim',
  },
  {
    'ellisonleao/gruvbox.nvim',
  },
}
