vim.lsp.enable('jsonls')
vim.lsp.config('jsonls', {
  before_init = function(_, client_config)
    client_config.settings.json = client_config.settings.json or {}
    client_config.settings.json.schemas = require('schemastore').json.schemas()
  end,
  settings = {
    json = {
      schemas = {},
      validate = { enable = true },
    },
  },
})

return {
  Utils.ts_ensure_installed({ 'json' }),
  Utils.mason_ensure_install({ 'json-lsp' }),
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
  },
}
