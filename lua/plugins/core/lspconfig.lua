---@module 'lazy'
---@type LazyPluginSpec[]
return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    priority = 1001,
    opts = {},
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    dependencies = {
      'mason-org/mason-lspconfig.nvim', -- allow lspconfig package names,
    },
    opts = { ensure_installed = {} },
    opts_extend = { 'ensure_installed' },
  },

  {
    'neovim/nvim-lspconfig',
    lazy = false,
  },
}
