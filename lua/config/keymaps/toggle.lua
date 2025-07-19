local toggle_utils = require('lib.toggle-utils')

local toggle_b = toggle_utils.toggle_b
local toggle_g = toggle_utils.toggle_g
local toggle_lsp = toggle_utils.toggle_lsp

local toggle_keys = {
  -- First row: qwertyuiop
  w = Snacks.toggle.option('wrap', { name = '[W]rap' }),

  -- Second row: asdfghjkl
  s = toggle_lsp('cspell_ls', 'C[S]pell'),
  d = Snacks.toggle.diagnostics({ name = '[D]iagnostics' }),
  f = toggle_b('inogai__no_autoformat', '[F]ormat (Buffer)', { default = false, reversed = true }),
  F = toggle_g('inogai__no_autoformat', '[F]ormat (Global)', { default = false, reversed = true }),
  h = Snacks.toggle.inlay_hints({ name = '[H]ints' }),

  -- Third row: zxcvbnm
  c = Snacks.toggle({
    name = '[C]oncealing',
    set = function(val) vim.o.conceallevel = val and 2 or 0 end,
    get = function() return vim.o.conceallevel == 2 end,
  }),
  b = Snacks.toggle({
    name = '[B]lame Line',
    set = function(val) require('gitsigns').toggle_current_line_blame(val) end,
    get = function()
      local blame = require('gitsigns').toggle_current_line_blame
      blame()
      return blame()
    end,
  }),
  B = Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark [B]ackground' }),
}

for key, toggle in pairs(toggle_keys) do
  toggle:map('<leader>u' .. key)
end
