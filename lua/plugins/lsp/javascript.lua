local FILE_TYPES = {
  has_tag = { 'javascriptreact', 'typescriptreact', 'vue', 'html' },
  has_code = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  all = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'html' },
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'jsdoc' },
    },
    opts_extend = { 'ensure_installed' },
  },

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
        return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
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
    'neovim/nvim-lspconfig',
    optional = true,
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'vtsls',
        'tailwindcss',
        'unocss',

        'eslint_d',
      },
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
        },
        tailwindcss = {},
        unocss = {},
      },
      on_setup = {
        vtsls = function(_, opts)
          Utils.lsp_on_attach(function(client, buffer)
            client.commands['_typescript.moveToFileRefactoring'] = function(command, ctx)
              ---@type string, string, lsp.Range
              local action, uri, range = unpack(command.arguments)

              local function move(newf)
                client:request('workspace/executeCommand', {
                  command = command.command,
                  arguments = { action, uri, range, newf },
                })
              end

              local fname = vim.uri_to_fname(uri)
              client:request('workspace/executeCommand', {
                command = 'typescript.tsserverRequest',
                arguments = {
                  'getMoveToRefactoringFileSuggestions',
                  {
                    file = fname,
                    startLine = range.start.line + 1,
                    startOffset = range.start.character + 1,
                    endLine = range['end'].line + 1,
                    endOffset = range['end'].character + 1,
                  },
                },
              }, function(_, result)
                ---@type string[]
                local files = result.body.files
                table.insert(files, 1, 'Enter new path...')
                vim.ui.select(files, {
                  prompt = 'Select move destination:',
                  format_item = function(f) return vim.fn.fnamemodify(f, ':~:.') end,
                }, function(f)
                  if f and f:find('^Enter new path') then
                    vim.ui.input({
                      prompt = 'Enter move destination:',
                      default = vim.fn.fnamemodify(fname, ':h') .. '/',
                      completion = 'file',
                    }, function(newf) return newf and move(newf) end)
                  elseif f then
                    move(f)
                  end
                end)
              end)
            end
          end, { 'vtsls' })
        end,
      },
    },
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
