return {
  {
    'copilotlsp-nvim/copilot-lsp',
    init = function()
      vim.lsp.enable('copilot_ls')
      vim.g.copilot_nes_debounce = 500
    end,
  },
}
