---@class MyHeirline.Filename.Self
---@field _root string
---@field _path string
---@field _file string

---@class MyHeirline.Filename.Path.Self : MyHeirline.Filename.Self
---@field _path_body string
---@field _path_root string

---@type MyHeirline.Unit<MyHeirline.Filename.Path.Self>
local Path = {
  init = function(self)
    self._path_body = ''
    self._path_root = ''

    local plpath = require('plenary.path')

    local head = vim.fn.fnamemodify(self._file, ':h')
    local head_rel = plpath:new(head):make_relative(self._root)

    -- if `head_rel` is not precedent to root, then no need to show root
    if head_rel:sub(0, 1) == '/' or head_rel:find(':/') then
      self._path_body = vim.fn.fnamemodify(head_rel, ':~') .. '/'
      return
    end

    -- if `head_rel` is root, then no need to show body
    if head_rel == '.' then
      self._path_root = vim.fn.fnamemodify(self._root, ':~') .. '/'
      return
    end

    self._path_root = vim.fn.fnamemodify(self._root, ':~') .. '/'
    self._path_body = head_rel .. '/'
  end,

  {
    {
      hl = { fg = 'fg3', bg = 'bg1' },
      flexible = 1,
      {
        provider = function(self) return self._path_root end,
      },
      {
        provider = function(self) return vim.fn.pathshorten(self._path_root) end,
      },
      {
        provider = '',
      },
    },
    {
      hl = { fg = 'green', bg = 'bg1' },
      flexible = 2,
      {
        provider = function(self) return self._path_body end,
      },
      {
        provider = function(self) return vim.fn.pathshorten(self._path_body) end,
      },
      {
        provider = '',
      },
    },
  },
}

---@type MyHeirline.Unit<MyHeirline.Filename.Self>
local Name = {
  hl = { fg = 'fg1', bg = 'bg1' },
  provider = function(self) return vim.fn.fnamemodify(self._file, ':t') end,
}

---@type MyHeirline.Unit<MyHeirline.Filename.Self>
local Size = {
  hl = { fg = 'fg3', bg = 'bg1' },
  provider = function(self)
    local nr = vim.fn.getfsize(self._file)
    local magnitude = 1
    local unit_map = { 'B', 'k', 'M', 'G', 'T' }
    while nr >= 100 do
      nr = nr / 1024
      magnitude = magnitude + 1
    end
    local nr_str = string.format('%.2f', nr)
    nr_str = nr_str:sub(0, 4) -- digits before '.' is always <= 2, so it's safe say this would be 3 effective numbers
    return nr_str .. unit_map[magnitude]
  end,
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    return enc ~= 'utf-8' and enc:upper()
  end,
}

local Filename = {
  ---@param self MyHeirline.Filename.Self
  init = function(self)
    self._root = vim.fn.getcwd()
    self._file = vim.fn.expand('%:p')
  end,
  update = { 'BufEnter', 'BufWritePost', 'DirChanged', 'VimResized' },

  { provider = ' ' },
  Path,
  Name,
  { provider = ' ' },
  Size,
  { provider = ' ' },
  FileEncoding,
}

return Filename
