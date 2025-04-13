local function enable_workspace_diagnostics()
  for _, client in ipairs(vim.lsp.buf_get_clients()) do
    require('workspace-diagnostics').populate_workspace_diagnostics(client, 0)
  end
  Utils.lsp_on_attach(function(client, buffer)
    --
    require('workspace-diagnostics').populate_workspace_diagnostics(client, 0)
  end)
end

--- @param cmd string
local function ws(cmd)
  return function()
    enable_workspace_diagnostics()
    vim.cmd(cmd)
  end
end

Utils.lsp_on_attach(
  function(client, buffer)
    vim.api.nvim_buf_create_user_command(buffer, 'WorkspaceDiagnostics', ws('Trouble diagnostics toggle'), { desc = 'Toggle Workspace Diagnostics' })
  end,
  { 'eslint' }
)

return {
  {
    'artemave/workspace-diagnostics.nvim',
  },

  {
    'folke/trouble.nvim',
    lazy = true,
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        ws('Trouble diagnostics toggle'),
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
