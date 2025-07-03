---@module 'snacks'

return {
  {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
      image = {
        doc = {
          enable = true,
          max_width = 80,
          max_height = 10,
        },
      },
    },
  },
}
