-- Provides powerful text objects based on treesitter queries

---@class CustomTextObjectSpec
---@field key string
---@field desc string
---@field spec function | table

---@param custom_textobjects CustomTextObjectSpec[]
local function setup_which_key(custom_textobjects)
  Utils.on_load('which-key.nvim', function()
    local prefixes = { around = 'a', inside = 'i' }
    local ret = { mode = { 'x' } }

    for _, prefix in pairs(prefixes) do
      for _, to in ipairs(custom_textobjects) do
        ---@type wk.Spec
        ret[#ret + 1] = { prefix .. to.key, desc = to.desc }
      end
    end

    require('which-key').add(ret, { notify = false })
  end)
end

---@param custom_textobjects CustomTextObjectSpec[]
local function setup_mini_ai(opts, custom_textobjects)
  ---@type table<string, function|table>
  local custom_textobjects_tbl = {}

  for _, to in ipairs(custom_textobjects) do
    custom_textobjects_tbl[to.key] = to.spec
  end

  require('mini.ai').setup(vim.tbl_deep_extend('force', opts, {
    custom_textobjects = custom_textobjects_tbl,
  }))
end

---@type LazyPluginSpec[]
return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    -- Provides powerful text objects based on treesitter queries
    'nvim-mini/mini.ai',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = function()
      local ai = require('mini.ai')

      ---@type CustomTextObjectSpec[]
      local textobjects = {
        {
          key = 'o',
          desc = 'code block',
          spec = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }),
        },
        {
          key = 'f',
          desc = 'function',
          spec = ai.gen_spec.treesitter({ a = { '@function.outer' }, i = { '@function.inner' } }),
        },
        {
          key = 'c',
          desc = 'class',
          spec = ai.gen_spec.treesitter({ a = { '@class.outer' }, i = { '@class.inner' } }),
        },
        {
          key = 'u',
          desc = 'function call',
          spec = ai.gen_spec.function_call(),
        },
        {
          key = 'U',
          desc = 'function call (without dot)',
          spec = ai.gen_spec.function_call({ name_pattern = '[%w_]' }),
        },
      }

      return {
        n_lines = 500,
        custom_textobjects = textobjects,
      }
    end,
    config = function(_, opts)
      ---@type CustomTextObjectSpec[]
      local textobjects = opts.custom_textobjects or {}
      setup_which_key(textobjects)
      setup_mini_ai(opts, textobjects)
    end,
  },
}
