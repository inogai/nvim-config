return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts_extend = { 'ensure_installed' },
    opts = { ensure_installed = { 'rust' } },
  },

  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = { 'rust_analyzer' },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
