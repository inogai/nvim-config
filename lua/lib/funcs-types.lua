---@meta

---@class lib.R
R = {}

---@generic T
---@param tbl T[]
---@param fn fun(v: T): boolean
---@return T[]
function R.filter(tbl, fn) end

---@generic T
---@param fn fun(v: T): boolean
---@return fun(tbl: T[]): T[]
function R.filter(fn) end

---@generic T
---@param tbl T[]
---@param fn fun(v: T): boolean
---@return boolean
function R.every(tbl, fn) end

---@generic T
---@param fn fun(v: T): boolean
---@return fun(tbl: T[]): boolean
function R.every(fn) end

---@generic T
---@param tbl T[]
---@param fn fun(v: T): boolean
---@return boolean
function R.any(tbl, fn) end

---@generic T
---@param fn fun(v: T): boolean
---@return fun(tbl: T[]): boolean
function R.any(fn) end

---@generic T, R
---@param data T[]
---@param fn fun(data: T): R
---@return R[]
function R.map(data, fn) end

---@generic T, R
---@param fn fun(data: T): R
---@return fun(data: T[]): R[]
function R.map(fn) end

---@generic T1, T2
---@param data T1
---@param f1 fun(data: T1): T2
---@return T2
function R.pipe(data, f1) end

---@generic T1, T2, T3
---@param data T1
---@param f1 fun(data: T1): T2
---@param f2 fun(data: T2): T3
---@return T3
function R.pipe(data, f1, f2) end

---@generic T1, T2, T3, T4
---@param data T1
---@param f1 fun(data: T1): T2
---@param f2 fun(data: T2): T3
---@param f3 fun(data: T3): T4
---@return T4
function R.pipe(data, f1, f2, f3) end
