local setupAutocmds = function()
  local group = vim.api.nvim_create_augroup('InogaiAutoformat', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    callback = function()
      if vim.g.inogai_autoformat ~= false then
        vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
        require('conform').format({ async = false })
      end
    end,
  })
end

local function configureAutoformat()
  vim.notify('Configuring autoformat...', vim.log.levels.DEBUG)
  vim.g.inogai_autoformat = true
  require('snacks.toggle')
    .new({
      name = 'Autoformat',
      set = function(val) vim.g.inogai_autoformat = val end,
      get = function() return vim.g.inogai_autoformat ~= false end,
    })
    :map('<leader>uf')

  setupAutocmds()
end

--- @type LazyPluginSpec[]
return {
  {
    -- Provides a universal interface for formatting code
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    init = function()
      configureAutoformat()
      -- configure autoformat again to make it run after obsidian
      Utils.on_load('obsidian.nvim', setupAutocmds)
    end,
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
      default_format_opts = {
        timeout_ms = 2000,
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
