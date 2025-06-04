return {
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = {
      -- pnpm i -g @vlabo/cspell-lsp
      ensure_installed = {},
      servers = {
        cspell_ls = {},
      },
    },
  },
}
