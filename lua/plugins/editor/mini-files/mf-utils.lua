local M = {}

---@param cwd string
function M.toggle(cwd)
  local MiniFiles = require('mini.files')
  if not MiniFiles.close() then MiniFiles.open(cwd, true) end
end

---Keep track of MiniFiles buffers
---@type integer[]
M.mf_buffers = {}

---@param cwd string
function M.focus(cwd)
  local MiniFiles = require('mini.files')
  MiniFiles.open(cwd, false)
end

---@param file string
function M.focus_file(file)
  local dirname = vim.fn.fnamemodify(file, ':p:h')
  local basename = vim.fn.fnamemodify(file, ':t')

  vim.api.nvim_create_augroup('my.mini_files.focus_file', { clear = true })

  local function cursor_basename()
    local line = vim.fn.search(basename, 'w')
    if line == 0 then
      vim.notify("[mf.utils.focus_file] File '" .. basename .. "' not found in the explorer.")
      return
    end
    vim.fn.cursor(line, 1)
    vim.api.nvim_create_augroup('my.mini_files.focus_file', { clear = true })
  end

  vim.api.nvim_create_autocmd('User', {
    group = 'my.mini_files.focus_file',
    pattern = 'MiniFilesExplorerOpen',
    callback = cursor_basename,
  })

  M.focus(dirname)
end

---@param blacklist integer[]
function M._find_last_active_file(blacklist)
  local bufs = vim.api.nvim_list_bufs()
  local last_active_dir = nil
  local last_active_time = 0

  for _, buf in ipairs(bufs) do
    if vim.tbl_contains(blacklist, buf) then goto continue end

    local bufinfo = vim.fn.getbufinfo(buf)[1]

    if not vim.fn.filereadable(bufinfo.name) then goto continue end

    if bufinfo.lastused > last_active_time then
      last_active_time = bufinfo.lastused
      last_active_dir = bufinfo.name
    end

    ::continue::
  end

  return last_active_dir
end

function M.foucs_last_active_file()
  local laf = M._find_last_active_file(M.mf_buffers)

  if laf == nil then
    print('No dir to be focused.')
    return
  end

  M.focus_file(laf)
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    -- Keep track of MiniFiles buffers
    table.insert(M.mf_buffers, args.data.buf_id)

    -- Bind '@' to focus the last active file in the MiniFiles buffer
    vim.keymap.set('n', '@', M.foucs_last_active_file, { buffer = args.data.buf_id })
  end,
})

return M
