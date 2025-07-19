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
    module = 'blink-copilot',
    score_offset = 100,
    async = true,
  },
}
