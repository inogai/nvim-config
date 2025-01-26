local M = {}

---@param on_attach fun(client:vim.lsp.Client, buffer)
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

return M
