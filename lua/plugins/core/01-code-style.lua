--- @type LazyPluginSpec[]
return {
  {
    -- Provides a universal interface for formatting code
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
  {
    -- Provides a framework for running linters
    -- Currently, only used for markdownlint-cli2
    'mfussenegger/nvim-lint',
    ft = { 'markdown' },
    opts = {},
    config = function(_, opts)
      require('lint').linters_by_ft = opts.linters_by_ft or {}
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function() require('lint').try_lint() end,
      })
    end,
  },
}
