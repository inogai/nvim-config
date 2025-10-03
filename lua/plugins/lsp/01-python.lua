Utils.lsp_on_attach_v2('ruff', function(client)
  -- ruff only support hover for noqa directives
  -- causing popup: 'No information available'
  -- https://github.com/astral-sh/ruff/issues/11719
  client.server_capabilities.hoverProvider = false
end)

return {
  Utils.ts_ensure_installed({ 'python' }),
  Utils.mason_ensure_install({ 'basedpyright', 'ruff', 'debugpy' }),
  {
    'linux-cultist/venv-selector.nvim',
    ft = 'python',
    keys = {
      { '<localleader>v', '<Cmd>VenvSelect<CR>', '[V]env Select' },
    },
    ---@module 'venv-selector.config'
    ---@type venv-selector.Settings
    opts = {},
  },
  -- {
  --   'mfussenegger/nvim-dap-python',
  --   ft = 'python',
  --   dependencies = {
  --     'mfussenegger/nvim-dap',
  --   },
  --   config = function() require('dap-python').setup('debugpy-adapter') end,
  -- },
}
