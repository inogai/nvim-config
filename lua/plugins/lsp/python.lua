vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')

Utils.lsp_on_attach_v2('ruff', function(client)
  -- ruff only support hover for noqa directives
  -- causing popup: 'No information available'
  -- https://github.com/astral-sh/ruff/issues/11719
  client.server_capabilities.hoverProvider = false
end)

return {
  Utils.ts_ensure_installed({ 'python' }),
  Utils.mason_ensure_install({ 'basedpyright', 'ruff' }),
  {
    'linux-cultist/venv-selector.nvim',
    cmd = 'VenvSelect',
    dependencies = {
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
      'neovim/nvim-lspconfig',
      -- 'mfussenegger/nvim-dap',
      -- 'mfussenegger/nvim-dap-python', --optional
    },
    ft = 'python',
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    opts = {},
    keys = {
      { '<leader>cv', '<Cmd>VenvSelect<CR>' },
    },
  },

  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    -- install debugpy in the venv
    config = function() require('dap-python').setup(vim.g.python3_host_prog) end,
  },
}
