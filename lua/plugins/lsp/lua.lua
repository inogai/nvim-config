vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      hint = { enable = true },
    },
  },
})

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = { 'lua_ls', 'stylua' },
    },
  },
}
