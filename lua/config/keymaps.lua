vim.keymap.set('n', 's', '')

---@type LazyKeysSpec[]
local keys = {
  -- Pasting
  { '<D-v>', 'p', desc = 'Paste', mode = { 'n' } },
  --  Visual: store replaced content in "_  instead of "+
  { 'p', '"_dP', desc = 'Paste Over', mode = { 'v' } },
  { '<D-v>', '"_dP', desc = 'Paste Over', mode = { 'v' } },

  { '<D-v>', '<C-r>+', desc = 'Paste', mode = { 'i', 'c' } },
  { '<D-v>', '<C-\\><C-o>"+p"', desc = 'Paste', mode = { 't' } },

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
    lhs = lhs:gsub('%<%D%-', '<C-')
  end
  vim.keymap.set(mode, lhs, spec[2], { desc = spec.desc })
end

---@class ToggleOpts
---@field default? boolean
---@field reversed? boolean

---@param var string
---@param name string
---@param opts ToggleOpts
local function toggle_g(var, name, opts)
  if vim.g[var] == nil then
    vim.g[var] = opts.default
  end

  local reversed = function(x) return x end
  if opts.reversed then
    reversed = function(x) return not x end
  end

  return Snacks.toggle({
    name = name,
    set = function(val) vim.g[var] = reversed(val) end,
    get = function() return reversed(vim.g[var]) end,
  })
end

---@param var string
---@param name string
---@param opts ToggleOpts
local function toggle_b(var, name, opts)
  vim.api.nvim_create_augroup('toggle_b', { clear = false })
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
      if vim.b[var] == nil then
        vim.b[var] = opts.default
      end
    end,
    group = 'toggle_b',
  })

  local reversed = function(x) return x end
  if opts.reversed then
    reversed = function(x) return not x end
  end

  return Snacks.toggle({
    name = name,
    set = function(val) vim.b[var] = reversed(val) end,
    get = function() return reversed(vim.b[var]) end,
  })
end

local toggle_keys = {
  f = toggle_b('inogai__no_autoformat', '[F]ormat (Buffer)', { default = false, reversed = true }),
  F = toggle_g('inogai__no_autoformat', '[F]ormat (Global)', { default = false, rreversed = true }),
  w = Snacks.toggle.option('wrap', { name = '[W]rap' }),
  h = Snacks.toggle.inlay_hints({ name = '[H]ints' }),
  B = Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark [B]ackground' }),
  b = Snacks.toggle({
    name = '[B]lame Line',
    set = function(val) require('gitsigns').toggle_current_line_blame(val) end,
    get = function()
      local blame = require('gitsigns').toggle_current_line_blame
      blame()
      return blame()
    end,
  }),
  c = Snacks.toggle({
    name = '[C]oncealing',
    set = function(val) vim.o.conceallevel = val and 2 or 0 end,
    get = function() return vim.o.conceallevel == 2 end,
  }),
}

for key, toggle in pairs(toggle_keys) do
  toggle:map('<leader>u' .. key)
end
