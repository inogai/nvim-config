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
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  -- stylua: ignore
  keys = {
    { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader><space>', function() Snacks.picker.files() end, desc = 'Find Files' },
    -- find
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Find Config File' },
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },
    -- git
    { '<leader>gc', function() Snacks.picker.git_log() end, desc = 'Git Log' },
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
    -- Grep
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    -- search
    { "<leader>s'", function() Snacks.picker.registers() end, desc = 'Registers' },
    { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
    { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
    { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
    { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
    { '<leader>qp', function() Snacks.picker.projects() end, desc = 'Projects' },
    -- LSP
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },

    { '<leader>gl', function() Snacks.terminal('lazygit') end, desc = 'LSP Symbols' },
  },
}
