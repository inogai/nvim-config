return {
  {
    'neovim/nvim-lspconfig',
    opts_extend = { 'ensure_installed', 'termux_no_install' },
    opts = {
      ensure_installed = { 'shfmt' },
    },
  },

  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters = {
        shfmt = {
          -- prepend_args = { '-i', '2' },
        },
      },
      formatters_by_ft = {
        sh = { 'shfmt' },
      },
    },
  },
}
