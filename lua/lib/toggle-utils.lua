---@class ToggleOpts
---@field default? boolean
---@field reversed? boolean

local M = {}

---Create a global variable toggle
---@param var string Variable name
---@param name string Display name
---@param opts ToggleOpts Options
---@return table Snacks toggle object
function M.toggle_g(var, name, opts)
  if vim.g[var] == nil then vim.g[var] = opts.default end

  local reversed = function(x) return x end
  if opts.reversed then reversed = function(x) return not x end end

  return Snacks.toggle({
    name = name,
    set = function(val) vim.g[var] = reversed(val) end,
    get = function() return reversed(vim.g[var]) end,
  })
end

---Create a buffer-local variable toggle
---@param var string Variable name
---@param name string Display name
---@param opts ToggleOpts Options
---@return table Snacks toggle object
function M.toggle_b(var, name, opts)
  vim.api.nvim_create_augroup('toggle_b', { clear = false })
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
      if vim.b[var] == nil then vim.b[var] = opts.default end
    end,
    group = 'toggle_b',
  })

  local reversed = function(x) return x end
  if opts.reversed then reversed = function(x) return not x end end

  return Snacks.toggle({
    name = name,
    set = function(val) vim.b[var] = reversed(val) end,
    get = function() return reversed(vim.b[var]) end,
  })
end

function M.toggle_lsp(server, name)
  ---@return vim.lsp.Client
  local function get_client()
    return vim.lsp.get_clients({ name = server, bufnr = 0 })[1] --
  end

  return Snacks.toggle({
    name = name,
    set = function(val)
      if val then
        vim.cmd('LspStart ' .. server)
      else
        vim.cmd('LspStop ' .. server)
      end
    end,
    get = function() return get_client() ~= nil end,
  })
end

return M
