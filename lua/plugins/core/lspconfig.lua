---@module 'lazy'
---@type LazyPluginSpec[]
return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    priority = 1001,
    opts = {},
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    opts = { ensure_installed = {} },
    opts_extend = { 'ensure_installed' },
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
    opts = {},
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup =
              vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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

      local ensure_installed = opts.ensure_installed or {}
      if vim.fn.has('termux') == 1 then
        ensure_installed = vim.tbl_filter(
          function(server) return not vim.tbl_contains(opts.termux_no_install or {}, server) end,
          ensure_installed
        )
      end

      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
    end,
  },
}
