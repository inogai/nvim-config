return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        basedpyright = {},
        ruff = {},
      },
      on_setup = {
        ruff = function()
          Utils.lsp_on_attach(function(client, buffer) client.server_capabilities.hoverProvider = false end, { 'ruff' })
        end,
      },
    },
  },

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
}
