Utils.lsp_on_attach(function(client)
  if client.name == 'eslint' then
    client.server_capabilities.documentFormattingProvider = true
  elseif client.name == 'vtsls' or client.name == 'volar' or client.name == 'jsonls' then
    client.server_capabilities.documentFormattingProvider = false
  end
end)

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        vtsls = {
          settings = {
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
              preferences = {
                importModuleSpecifier = 'non-relative',
                importModuleSpecifierEnding = 'js',
              },
            },
          },
        },
        tailwindcss = {},
        unocss = {},
        eslint = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
            'vue',
            'html',
            'markdown',
            'json',
            'jsonc',
            'yaml',
            'toml',
            'xml',
            'gql',
            'graphql',
            'astro',
            'svelte',
            'css',
            'less',
            'scss',
            'pcss',
            'postcss',
          },
        },
      },
    },
  },
}
