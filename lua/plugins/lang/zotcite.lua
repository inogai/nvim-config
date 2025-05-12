---@module 'lazy'
---@module 'blink.cmp'

---@type LazySpec
return {
  {
    'jalvesaq/zotcite',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
    },
    opts = {},
  },

  {
    'jalvesaq/cmp-zotcite',
  },

  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  },

  {
    'saghen/blink.cmp',
    optional = true,
    opts_extend = { 'sources.default' },
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { 'cmp_zotcite' },
        providers = {
          cmp_zotcite = {
            name = 'cmp_zotcite',
            module = 'blink.compat.source',
            score_offset = 101,
            async = true,

            transform_items = function(_, items)
              local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = 'Zotcite'
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
      },
    },
  },
}
