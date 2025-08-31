vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      hint = { enable = true },
    },
  },
})

return {
  Utils.mason_ensure_install({ 'lua_ls', 'stylua' }),
}
