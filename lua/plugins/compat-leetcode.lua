return {
  {
    'kawre/leetcode.nvim',
    lazy = true,
    cmd = 'Leet',
    build = ':TSUpdate html',
    dependencies = {
      -- 'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',

      -- optional
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-notify',
      -- 'nvim-tree/nvim-web-devicons',
    },
    opts = {
      ---@module 'leetcode'
      ---@type table<lc.lang, lc.inject>
      -- injector = {
      --   ['cpp'] = {
      --     before = { '#include <iostream>', '#include <vector>', 'using namespace std;' },
      --     after = 'int main() {}',
      --   },
      -- },
      ---@type lc.picker
      picker = { provider = 'fzf-lua' },
    },
  },
}
