local M = {}

---@param on_attach fun(client: vim.lsp.Client, buffer)
---@param name? string[]
function M.lsp_on_attach(on_attach, name)
  return vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or vim.tbl_contains(name, client.name)) then
        return on_attach(client, buffer)
      end
    end,
  })
end

---@param on_attach fun(client: vim.lsp.Client, buffer)
---@param name string | string[]
function M.lsp_on_attach_v2(name, on_attach)
  if type(name) == 'string' then name = { name } end

  return vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (vim.tbl_isempty(name) or vim.tbl_contains(name, client.name)) then
        return on_attach(client, buffer)
      end
    end,
  })
end

function M.is_loaded(name)
  local Config = require('lazy.core.config')
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

function M.expand_visual()
  local start = vim.fn.getpos('v')
  local finish = vim.fn.getpos('.')

  local sel = vim.fn.getregion(start, finish)

  return table.concat(sel, ' ')
end

function M.log(x) vim.notify(vim.inspect(x), vim.log.levels.INFO, { title = 'Log', render = 'minimal' }) end

---@param names string[]
---@return LazyPluginSpec
function M.mason_ensure_install(names)
  return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    optional = true,
    opts = {
      ensure_installed = names,
    },
  }
end

---@param names string[]
---@return LazyPluginSpec
function M.ts_ensure_installed(names)
  return {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = names,
    },
  }
end

return M
