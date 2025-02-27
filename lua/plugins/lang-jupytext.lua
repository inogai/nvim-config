return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = {
        'jupytext',
      },
      termux_no_install = {
        'jupytext',
      },
    },
    opts_extend = { 'ensure_installed', 'termux_no_install' },
  },

  {
    'goerz/jupytext.nvim',
    version = '0.2.0',
    opts = {}, -- see Options
  },
}
