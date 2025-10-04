-- Lua LSP configuration
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      hint = { enable = true },
    },
  },
})

return {
  Utils.ts_ensure_installed({ 'lua' }),
  Utils.mason_ensure_install({ 'lua_ls', 'stylua' }),
}
