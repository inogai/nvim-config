return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = { 'markdownlint-cli2', 'markdown-toc' },
      servers = {
        marksman = {},
      },
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    ft = { 'markdown', 'norg', 'rmd', 'org' },
    config = function(_, opts)
      require('render-markdown').setup(opts)
      Snacks.toggle({
        name = 'Render Markdown',
        get = function() return require('render-markdown.state').enabled end,
        set = function(enabled)
          local m = require('render-markdown')
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map('<leader>um')
    end,
  },
}
