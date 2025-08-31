return {
  Utils.ts_ensure_installed({ 'typst' }),
  Utils.mason_ensure_install({ 'prettypst' }),

  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters = {
        prettypst = {
          prepend_args = { '--use-configuration' },
        },
      },
      formatters_by_ft = {
        typst = {
          'prettypst',
        },
      },
    },
  },

  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
      open_cmd = "qutebrowser ':open -w %s'",
      port = 35872,
    },
  },
}
