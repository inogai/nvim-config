-- eslint also works for markdown files.
-- we enable it globally (only project with eslint config will actually use it),
-- if you want markdownlint only for markdown files, disable with eslint config.
vim.lsp.config('eslint', {
  filetypes = { 'markdown' },
})

-- Enable automatic continuation of markdown quotes
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- 'r' enables continuation of comments/elements on Enter
    -- 'o' enables continuation when using 'o' or 'O' to open new lines
    vim.opt_local.formatoptions:append('ro')

    vim.opt_local.comments = ''
    vim.opt_local.comments:append({ 'nb:>', 'nb:-', 'nb:*' })
  end,
})

return {
  Utils.ts_ensure_installed({ 'markdown', 'markdown_inline' }),
  Utils.mason_ensure_install({
    'markdownlint-cli2',
    'markdown-toc',
    -- use own fork of prettier for CJK wrapping
  }),

  {
    'stevearc/conform.nvim',
    optional = true,
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters = {
        ['@inogai/prettier'] = {
          command = 'pnpm',
          args = { 'dlx', '@inogai/prettier', '--stdin-filepath', '$FILENAME' },
        },

        ['markdown-toc'] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find('<!%-%- toc %-%->') then return true end
            end
            return false
          end,
        },
        ['markdownlint-cli2'] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(
              function(d) return d.source == 'markdownlint' end,
              vim.diagnostic.get(ctx.buf)
            )
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        ['markdown'] = { '@inogai/prettier', 'markdownlint-cli2', 'markdown-toc' },
        ['markdown.mdx'] = { '@inogai/prettier', 'markdownlint-cli2', 'markdown-toc' },
      },
    },
  },

  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
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
