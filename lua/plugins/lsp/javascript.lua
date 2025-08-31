local FILE_TYPES = {
  has_tag = { 'javascriptreact', 'typescriptreact', 'vue', 'html' },
  has_code = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  all = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'html' },
}

vim.lsp.enable('vtsls')
vim.lsp.enable('eslint')
vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      -- enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      -- updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = {
          enabled = 'literals',
          suppressWhenArgumentMatchesName = 't',
        },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
      preferences = {
        importModuleSpecifier = 'non-relative',
        -- importModuleSpecifierEnding = 'js',
      },
    },
  },
})

return {
  Utils.ts_ensure_installed({ 'jsdoc', 'javascript', 'typescript', 'html' }),
  Utils.mason_ensure_install({
    'eslint_d',
    'vtsls',
    'tailwindcss',
    'unocss',
  }),

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    ft = FILE_TYPES.has_tag,
    opts = {
      enable_autocmd = false,
    },
    config = function(opts)
      require('ts_context_commentstring').setup(opts)

      -- override the default get_option function to use ts_context_commentstring
      local get_option = vim.filetype.get_option
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.filetype.get_option = function(filetype, option)
        return option == 'commentstring'
            and require('ts_context_commentstring.internal').calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },

  {
    'nabekou29/js-i18n.nvim',
    ft = FILE_TYPES.all,
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
    },
    opts = {},
  },

  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        vue = { 'eslint_d' },
        json = { 'eslint_d' },
        yaml = { 'eslint_d' },
      },
    },
  },
}
