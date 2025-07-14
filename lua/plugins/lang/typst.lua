return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'typst' },
    },
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = { 'prettypst' },
      servers = {
        tinymist = {},
      },
    },
  },

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
