local M = {}

---@param cwd string
function M.toggle(cwd)
  local MiniFiles = require('mini.files')
  if not MiniFiles.close() then
    MiniFiles.open(cwd, true)
  end
end

function M.toggle_at_root() M.toggle(vim.fn.getcwd()) end

---@type integer[]
M.MF_BUFS = {}

---@param cwd string
function M.focus(cwd)
  local MiniFiles = require('mini.files')
  MiniFiles.open(cwd, false)
end

---@param blacklist integer[]
function M.find_last_active_file(blacklist)
  local bufs = vim.api.nvim_list_bufs()
  local last_active_dir = nil
  local last_active_time = 0

  for _, buf in ipairs(bufs) do
    if vim.tbl_contains(blacklist, buf) then
      goto continue
    end

    local bufinfo = vim.fn.getbufinfo(buf)[1]

    if not vim.fn.filereadable(bufinfo.name) then
      goto continue
    end

    if bufinfo.lastused > last_active_time then
      last_active_time = bufinfo.lastused
      last_active_dir = bufinfo.name
    end

    ::continue::
  end

  return last_active_dir
end

function M.foucs_last_active_file_dir()
  local laf = M.find_last_active_file(M.MF_BUFS)

  if laf == nil then
    print('No dir to be focused.')
    return
  end

  local last_active_dir = vim.fn.fnamemodify(laf, ':p:h')

  M.focus(last_active_dir)
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    table.insert(M.MF_BUFS, args.data.buf_id)
    vim.keymap.set('n', '@', M.foucs_last_active_file_dir, { buffer = args.data.buf_id })
  end,
})

return {
  {
    'echasnovski/mini.files',
    lazy = false,
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      mappings = {
        toggle_hidden = 'g.',
        reveal_cwd = '',
        change_cwd = 'gc',
        go_in_horizontal = '<C-w>s',
        go_in_vertical = '<C-w>v',
        go_in_horizontal_plus = '<C-w>S',
        go_in_vertical_plus = '<C-w>V',
        synchronize = ';',
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      { '<leader>e', M.toggle_at_root, desc = 'Files' },
    },
  },
}
