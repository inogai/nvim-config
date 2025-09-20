---@type LazyPluginSpec[]
return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    priority = 1001,
    opts = {},
  },

  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      automatic_enable = false,
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    opts = { ensure_installed = {} },
    opts_extend = { 'ensure_installed' },
  },

  {
    'neovim/nvim-lspconfig',
    lazy = false,
  },
}
