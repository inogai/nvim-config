local kind_icon = {
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
}

return {
  {
    'echasnovski/mini.snippets',
    version = false,
    opts = {},
  },

  {
    'saghen/blink.cmp',
    lazy = false,
    -- optional: provides snippets for the snippet source
    -- dependencies = 'rafamadriz/friendly-snippets',
    -- use a release tag to download pre-built binaries
    version = '*',

    dependencies = {
      'giuxtaposition/blink-cmp-copilot',
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        menu = {
          draw = {
            components = { kind_icon = kind_icon },
          },
        },
      },

      snippets = { preset = 'mini_snippets' },
      keymap = {
        preset = 'none',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-l>'] = { 'select_and_accept' },
        ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
        ['<Esc>'] = {
          function()
            local ms = require('mini.snippets')
            if ms.session.get() ~= nil then
              ms.session.stop()
            end
            return require('blink.cmp').hide()
          end,
          'fallback',
        },
        ['<C-Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      sources = {
        default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },

        providers = {
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
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
