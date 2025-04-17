return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'cpp' },
    },
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        clangd = {
          cmd = {
            '/usr/bin/clangd',
            '--query-driver=/opt/homebrew/bin/g++-*',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
          },
        },
      },
    },
  },

  {
    'p00f/clangd_extensions.nvim',
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = true,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = '',
          declaration = '',
          expression = '',
          specifier = '',
          statement = '',
          ['template argument'] = '',
        },
        kind_icons = {
          Compound = '',
          Recovery = '',
          TranslationUnit = '',
          PackExpansion = '',
          TemplateTypeParm = '',
          TemplateTemplateParm = '',
          TemplateParamObject = '',
        },
      },
    },
  },
}
