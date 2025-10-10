local astroTsPlugin = {
  name = '@astrojs/ts-plugin',
  location = vim.fn.stdpath('data')
    .. '/mason/packages/astro-language-server/node_modules/@astrojs/ts-plugin',
  enableForWorkspaceTypeScriptVersions = true,
}

vim.lsp.config('vtsls', {
  server = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          astroTsPlugin,
        },
      },
    },
  },
})

return {
  Utils.ts_ensure_installed({ 'astro' }),
  Utils.mason_ensure_install({ 'astro-language-server' }),
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        astro = { 'eslint_d', 'fallback', stop_after_first = true },
      },
    },
  },
}
