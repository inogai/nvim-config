vim.keymap.set('n', 's', '')

---@type LazyKeysSpec[]
local keys = {
  -- Editing
  { '<D-v>', '"+p"', desc = 'Paste' },
  { '<D-v>', '<C-r>+', desc = 'Paste', mode = { 'i', 'c' } },
  { '<D-v>', '<C-\\><C-o>"+p"', desc = 'Paste', mode = 't' },
  { '<Esc>', '<cmd>nohlsearch<CR>', desc = 'Clear search highlights' },

  -- Window
  { '<Esc><Esc>', '<C-\\><C-n>', desc = 'Terminal Normal', mode = 't' },

  -- Buffer
  { '<D-s>', '<cmd>w<cr><esc>', desc = '[S]ave File', mode = { 'i', 'x', 'n', 's' } },
  { '<leader>bd', function() Snacks.bufdelete() end, desc = '[B]uffer [D]elete' },

  -- Utils
  { '<leader>l', '<cmd>Lazy<cr>', desc = 'Lazy' },

  -- LSP
  { '<F2>', vim.lsp.buf.rename, desc = 'Rename Symbol', mode = { 'i', 'x', 'n', 's' } },
  { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostic [Q]uickfix list' },
  {
    ']d',
    function() vim.diagnostic.goto_next() end,
    -- function() vim.diagnostic.jump({ count = 1, float = true }) end,
    desc = 'Next [D]iagnostic',
  },
  {
    '[d',
    function() vim.diagnostic.goto_prev() end,
    -- function() vim.diagnostic.jump({ count = -1, float = true }) end,
    desc = 'Prev [D]iagnostic',
  },
  {
    ']e',
    function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    -- function() vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR }) end,
    desc = 'Next [D]iagnostic',
  },
  {
    '[e',
    function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    -- function() vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR }) end,
    desc = 'Prev [D]iagnostic',
  },

  -- Window Navigation
  { '<C-h>', '<C-w><C-h>', desc = 'Focus Left' },
  { '<C-l>', '<C-w><C-l>', desc = 'Focus Right' },
  { '<C-j>', '<C-w><C-j>', desc = 'Focus Down' },
  { '<C-k>', '<C-w><C-k>', desc = 'Focus Up' },

  { '<leader>ui', '<Cmd>Inspect<CR>', desc = 'Inspect' },
}

for _, spec in ipairs(keys) do
  local mode = spec.mode or 'n'
  local lhs = spec[1]
  if vim.fn.has('mac') ~= 1 then
    -- Use cmd on mac otherwise ctrl
    lhs = lhs:gsub('<D-', '<C-')
  end
  vim.keymap.set(mode, lhs, spec[2], { desc = spec.desc })
end
