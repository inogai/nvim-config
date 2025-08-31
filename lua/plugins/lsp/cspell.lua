vim.lsp.enable('cspell_ls')

return {
  Utils.mason_ensure_install({ 'cspell-lsp' }),
}
