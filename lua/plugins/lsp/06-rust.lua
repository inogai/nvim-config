return {
  Utils.ts_ensure_installed({ 'rust' }),
  Utils.mason_ensure_install({ 'rust_analyzer' }),

  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      automatic_enable = {
        exclude = { 'rust_analyzer' },
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
