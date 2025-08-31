return {
  Utils.mason_ensure_install({ 'shfmt' }),

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
