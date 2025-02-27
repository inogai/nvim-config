return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = { ensure_installed = { 'kotlin' } },
  },

  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      linters_by_ft = { kotlin = { 'ktlint' } },
    },
  },

  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = {
      ensure_installed = { 'ktlint' },
      servers = {
        kotlin_language_server = {},
      },
    },
  },

  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = { kotlin = { 'ktlint' } },
    },
  },
}
