---@type LazyPluginSpec[]
return {
  -- {
  --   'zbirenbaum/copilot.lua',
  --   enabled = false,
  --   opts = {},
  -- },

  {
    'copilotlsp-nvim/copilot-lsp',
    lazy = false,
    init = function()
      vim.g.copilot_nes_debounce = 500
      vim.lsp.enable('copilot_ls')
    end,
    keys = {
      {
        '<Tab>',
        function()
          local nes = require('copilot-lsp.nes')
          -- Try to jump to the start of the suggestion edit.
          -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
          if not nes.walk_cursor_end_edit() then
            nes.apply_pending_nes()
            nes.walk_cursor_end_edit()
          end
        end,
        mode = { 'n' },
      },
    },
  },
}
