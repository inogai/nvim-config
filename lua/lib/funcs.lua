local R = {}

---@param orig_fn function
---@param param_count number
local function auto_curry(orig_fn, param_count)
  return function(...)
    local args = { ... }
    -- if we have enough arguments, call the function
    if #args >= param_count then
      return orig_fn(unpack(args))
    end
    -- otherwise, return a new function that takes the remaining arguments
    return function(...)
      local remain_args = { ... }
      return orig_fn(unpack(remain_args), unpack(args))
    end
  end
end

function R._filter(fn)
  return function(tbl)
    local result = {}
    for _, v in ipairs(tbl) do
      if fn(v) then
        table.insert(result, v)
      end
    end
    return result
  end
end

R.filter = auto_curry(R._filter, 2)

function R._every(tbl, fn)
  for _, v in ipairs(tbl) do
    if not fn(v) then
      return false
    end
  end
  return true
end

R.every = auto_curry(R._every, 2)

function R._any(tbl, fn)
  for _, v in ipairs(tbl) do
    if fn(v) then
      return true
    end
  end
  return false
end

R.any = auto_curry(R._any, 2)

function R._map(tbl, fn) return vim.tbl_map(fn, tbl) end

R.map = auto_curry(R._map, 2)

function R.pipe(data, ...)
  local funcs = { ... }
  vim.notify(vim.inspect(data))
  vim.notify(vim.inspect(funcs))
  local result = data

  for _, fn in ipairs(funcs) do
    result = fn(result)
  end

  return result
end

function R.piped(...)
  local funcs = { ... }
  return function(data)
    return R.pipe(data, unpack(funcs))
    --
  end
end

---@module 'lib.funcs-types'
---@type lib.R
return R
