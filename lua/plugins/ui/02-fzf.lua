return {
  {
    'ibhagwan/fzf-lua',
    cmd = { 'FzfLua', 'Zz' },
    init = function()
      vim.api.nvim_create_user_command('Zz', function() FzfLua.zoxide({}) end, {})
    end,
    opts = function(_, opts)
      local actions = require('fzf-lua.actions')

      local config = require('fzf-lua.config')
      config.defaults.actions.files['ctrl-t'] = require('trouble.sources.fzf').open

      return {
        fzf_colors = true,
        defaults = {
          formatter = 'path.filename_first', -- formatter = 'path.dirname_first',
        },
        files = {
          actions = {
            ['ctrl-i'] = { actions.toggle_ignore },
            ['ctrl-h'] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ['ctrl-i'] = { actions.toggle_ignore },
            ['ctrl-h'] = { actions.toggle_hidden },
          },
        },
        lsp = {
          symbols = {
            symbol_hl = function(s) return 'TroubleIcon' .. s end,
            symbol_fmt = function(s) return s:lower() .. '\t' end,
            child_prefix = false,
          },
          code_actions = {
            previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
          },
        },
      }
    end,
    config = function(_, opts)
      require('fzf-lua').setup(opts)
      FzfLua.register_ui_select()
    end,
    keys = {
      { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
      { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
      {
        '<leader>,',
        '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
        desc = 'Switch Buffer',
      },
      { '<leader><space>', '<cmd>FzfLua files<cr>', desc = 'Find Files (Root Dir)' },
      -- goto
      {
        'gd',
        function() FzfLua.lsp_definitions({ jump1 = true, jump_on_cb = true }) end,
        desc = '[D]efinitions',
      },
      { 'gr', '<cmd>FzfLua lsp_references<cr>', desc = '[R]erferences' },
      { 'gy', '<cmd>FzfLua lsp_typedefs<cr>', desc = 'T[y]pe Definition' },
      { '<C-.>', '<cmd>FzfLua lsp_code_actions<cr>', desc = 'Code Actions', mode = { 'n', 'i', 's' } },
      -- search
      { '<leader>s"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
      { '<leader>sa', '<cmd>FzfLua autocmds<cr>', desc = 'Auto Commands' },
      { '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Buffer' },
      { '<leader>sc', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
      { '<leader>sC', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
      { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document Diagnostics' },
      { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Workspace Diagnostics' },
      { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep' },
      { '<leader>sh', function() FzfLua.helptags() end, desc = '[H]elp' },
      {
        '<leader>sh',
        function() FzfLua.helptags({ fzf_opts = { ['--query'] = Utils.expand_visual() } }) end,
        desc = '[H]elp',
        mode = { 'v' },
      },
      { '<leader>sH', '<cmd>FzfLua highlights<cr>', desc = 'Search Highlight Groups' },
      { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Key Maps' },
      { '<leader>sm', '<cmd>FzfLua marks<cr>', desc = 'Jump to Mark' },
      { '<leader>sR', '<cmd>FzfLua resume<cr>', desc = 'Resume' },
      { '<leader>sq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix List' },

      { '<leader>uC', '<cmd>FzfLua colorschemes<cr>', desc = 'Colorscheme with Preview' },
      {
        '<leader>ss',
        function() require('fzf-lua').lsp_document_symbols() end,
        desc = 'Goto Symbol',
      },
      {
        '<leader>sS',
        function() require('fzf-lua').lsp_live_workspace_symbols() end,
        desc = 'Goto Symbol (Workspace)',
      },
    },
  },
}
