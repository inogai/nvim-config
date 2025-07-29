local actions = require('plugins.core.blink-cmp.actions')
local providers = require('plugins.core.blink-cmp.providers')

return {
  -- Snippets
  {
    'echasnovski/mini.snippets',
    version = '*',
    config = function()
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup({
        snippets = {
          -- Load custom global snippets
          gen_loader.from_file('~/.config/nvim/snippets/global.json'),
          -- Load language-specific snippets from rtp
          gen_loader.from_lang(),
        },
      })
    end,
  },

  -- Blink Completion
  {
    'saghen/blink.cmp',
    lazy = false,
    version = '*',
    dependencies = {
      -- 'giuxtaposition/blink-cmp-copilot',
      'fang2hou/blink-copilot',
      'Kaiser-Yang/blink-cmp-avante',
    },
    opts_extend = { 'sources.default' },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
        },
        menu = {
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                -- Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },

      snippets = { preset = 'mini_snippets' },

      keymap = {
        preset = 'none',

        -- Snippets
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<Esc>'] = { actions.snippet_clear, 'fallback' },

        -- Navigation
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-l>'] = { 'select_and_accept', 'fallback' },

        -- Tab
        ['<Tab>'] = {
          function(cmp)
            if vim.b[vim.api.nvim_get_current_buf()].nes_state then
              cmp.hide()
              return (
                require('copilot-lsp.nes').apply_pending_nes()
                and require('copilot-lsp.nes').walk_cursor_end_edit()
              )
            end
            return nil
          end,
          'select_and_accept',
          'snippet_forward',
        },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      sources = {
        default = { 'copilot', 'avante', 'lsp', 'path', 'snippets', 'buffer' },
        providers = providers,
      },
    },
  },
}
