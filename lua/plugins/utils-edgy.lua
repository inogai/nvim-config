return {
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    opts = {
      animate = { enabled = false },
      bottom = {
        {
          ft = 'snacks_terminal',
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == '' end,
        },
        {
          ft = 'help',
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf) return vim.bo[buf].buftype == 'help' end,
        },
      },
      right = {
        {
          ft = 'iron',
          size = { width = 0.5 },
        },
      },
    },
  },
}
