return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    priority = 1001,
    opts = {},
  },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    opts = {
      ensure_installed = {
        'stylua',
        'lua_ls',
        'json-lsp',
      },
      termux_no_install = {
        'stylua',
        'lua_ls',
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                arrayIndex = 'Disable',
                enable = true,
              },
            },
          },
        },
      },
    },
    opts_extend = { 'ensure_installed', 'termux_no_install' },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
              end,
            })
          end
        end,
      })

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
      })

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      --
      local default_capabilities = require('blink.cmp').get_lsp_capabilities()
      -- ufo capabilities
      default_capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      -- END ufo capabilities
      local servers = opts.servers or {}

      local ensure_installed = opts.ensure_installed or {}
      if vim.fn.has('termux') == 1 then
        ensure_installed = vim.tbl_filter(function(server) return not vim.tbl_contains(opts.termux_no_install or {}, server) end, ensure_installed)
      end
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      local on_setup = opts.on_setup or {}

      local function setup(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend(
          'force',
          default_capabilities,
          server.capabilities or {}
          --
        )

        if on_setup[server_name] then
          on_setup[server_name](server, opts)
        end
        vim.lsp.enable(server_name)
        vim.lsp.config(server_name, {
          settings = server,
        })
      end

      for server_name, _ in pairs(servers) do
        setup(server_name)
      end
    end,
  },
}
