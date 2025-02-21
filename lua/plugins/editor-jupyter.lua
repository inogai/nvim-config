return {
  {
    '3rd/image.nvim',
  },

  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    build = ':UpdateRemotePlugins',
    ft = 'python',
    init = function()
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_virt_text_output = true
      vim.g.molten_auto_open_output = false
      vim.g.molten_auto_init_behavior = 'raise'
    end,
    keys = {
      { '<localleader>x', '<Cmd>MoltenShowOutput<CR><Cmd>:noautocmd MoltenEnterOutput<CR>', desc = 'Open Molten Output' },
    },
  },

  {
    'inogai/NotebookNavigator.nvim',
    dependencies = {
      -- 'echasnovski/mini.comment',
      -- 'hkupty/iron.nvim', -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      'benlubas/molten-nvim', -- alternative repl provider
      -- 'anuvyklack/hydra.nvim',
    },
    event = 'VeryLazy',
    ft = 'python',
    opts = {
      repl_provider = 'molten',
    },
    keys = {
      { ']x', function() require('notebook-navigator').move_cell('d') end, desc = 'Next Cell' },
      { '[x', function() require('notebook-navigator').move_cell('u') end, desc = 'Prev Cell' },
      { 'X', function() require('notebook-navigator').run_cells_above() end, desc = 'Run Cells Above' },
      { 'x', function() require('notebook-navigator').run_cell() end, desc = 'Run Cell' },
    },
  },
}
