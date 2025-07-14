vim.api.nvim_create_user_command('Dashboard', function() Snacks.dashboard.open() end, {})

local hlgroups = {
  SnacksDashboardNormal = 'Normal', -- Normal for the dashboard
  SnacksDashboardDesc = 'Conceal', -- Description text in dashboard
  SnacksDashboardFile = 'Conceal', -- Dashboard file items
  SnacksDashboardDir = 'NonText', -- Directory items
  SnacksDashboardFooter = 'String', -- Dashboard footer text
  SnacksDashboardHeader = 'Title', -- Dashboard header text
  SnacksDashboardIcon = 'Normal', -- Dashboard icons
  SnacksDashboardKey = 'Statement', -- Keybind text
  SnacksDashboardTerminal = 'Normal', -- Terminal text
  SnacksDashboardSpecial = 'Statement', -- Special elements
  SnacksDashboardTitle = 'Title', -- Title text
}

return {
  'inogai/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = require('lib.dashboard'),
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { '<leader>gl', function() Snacks.lazygit.open() end, desc = '[L]azygit' },
    { '<C-/>', function() Snacks.terminal.toggle() end, desc = 'Terminal', mode = { 'n', 'i', 't' } },
  },
  config = function(_, opts)
    require('snacks').setup(opts)
    for hlgroup, target in pairs(hlgroups) do
      vim.api.nvim_set_hl(0, hlgroup, { link = target })
    end
  end,
}
