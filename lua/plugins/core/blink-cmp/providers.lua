return {
  avante = {
    name = 'avante',
    module = 'blink-cmp-avante',
    score_offset = 1000,
    async = true,
    opts = {
      avante = {
        command = {
          get_kind_name = function(_) return 'AvanteCmd' end,
        },
        mention = {
          get_kind_name = function(_) return 'AvanteMention' end,
        },
      },
      kind_icons = {
        AvanteCmd = '',
        AvanteMention = '',
      },
    },
  },

  copilot = {
    name = 'copilot',
    module = 'blink-cmp-copilot',
    score_offset = 100,
    async = true,
    transform_items = function(_, items)
      local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
      local kind_idx = #CompletionItemKind + 1
      CompletionItemKind[kind_idx] = 'Copilot'
      for _, item in ipairs(items) do
        item.kind = kind_idx
      end
      return items
    end,
  },
}