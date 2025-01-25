vim.api.nvim_create_user_command('Dashboard', function()
  Snacks.dashboard.open()
end, {})

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

for hlgroup, target in pairs(hlgroups) do
  vim.api.nvim_set_hl(0, hlgroup, { link = target })
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = require('plugins.utils-snacks.dashboard'),
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
