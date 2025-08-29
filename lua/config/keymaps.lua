require('config.keymaps.toggle')

---@type LazyKeysSpec[]
local keys = {
  -- Pasting
  { '<D-a>', 'ggVG', desc = 'Select All', mode = { 'n', 'i' } },
  { '<D-v>', 'p', desc = 'Paste', mode = { 'n' } },
  --  Visual: store replaced content in "_  instead of "+
  { 'p', '"_dP', desc = 'Paste Over', mode = { 'v' } },
  { '<D-v>', '"_dP', desc = 'Paste Over', mode = { 'v' } },

  { '<D-v>', '<C-r>+', desc = 'Paste', mode = { 'i', 'c' } },
  { '<D-v>', '<C-\\><C-o>"+p"', desc = 'Paste', mode = { 't' } },

  { '<Esc>', '<cmd>nohlsearch<CR>', desc = 'Clear search highlights' },
  { 's', '', desc = '+Surround', mode = { 'n', 'v' } },

  -- Yanking
  {
    'yp',
    function()
      local path = vim.fn.expand('%')
      vim.fn.setreg('+', path)
      vim.notify('Path copied to clipboard:\n' .. path)
    end,
    desc = 'Path',
  },
  {
    'yP',
    function()
      local path = vim.fn.expand('%:p')
      vim.fn.setreg('+', path)
      vim.notify('Path copied to clipboard:\n' .. path)
    end,
    desc = 'Path (Absolute)',
  },

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
    function() vim.diagnostic.jump({ count = 1, float = true }) end,
    desc = 'Next [D]iagnostic',
  },
  {
    '[d',
    function() vim.diagnostic.jump({ count = -1, float = true }) end,
    desc = 'Prev [D]iagnostic',
  },
  {
    ']e',
    function() vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR }) end,
    desc = 'Next [E]rror',
  },
  {
    '[e',
    function() vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR }) end,
    desc = 'Prev [E]rror',
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
    lhs = lhs:gsub('%<%D%-', '<C-')
  end
  vim.keymap.set(mode, lhs, spec[2], { desc = spec.desc })
end
