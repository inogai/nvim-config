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

---@class Node
---@field extmark_id integer
---@field text? string
---@field tabstop? string

---@param node Node
---@return boolean
local function node_is_tabstop(node) return node.tabstop ~= nil end

---@param node Node
---@return boolean
local function node_under_cursor(node)
  local current_buf = 0
  local ns_id = vim.api.nvim_create_namespace('MiniSnippetsNodes')

  local extmark = vim.api.nvim_buf_get_extmark_by_id(current_buf, ns_id, node.extmark_id, {})
  local cursor = vim.api.nvim_win_get_cursor(0)
  cursor[1] = cursor[1] - 1 -- cursor is 1-based, but extmark is 0-based

  local offset = 0
  if node.text ~= nil then
    offset = #node.text
  end

  if cursor[1] == extmark[1] and cursor[2] >= extmark[2] and cursor[2] <= extmark[2] + offset then
    return true
  end

  return false
end

return {
  {
    'echasnovski/mini.snippets',
    version = '*',
    opts = {},
  },

  {
    'saghen/blink.cmp',
    lazy = false,
    -- optional: provides snippets for the snippet source
    -- dependencies = 'rafamadriz/friendly-snippets',
    -- use a release tag to download pre-built binaries
    version = '0.14.*',

    dependencies = {
      'giuxtaposition/blink-cmp-copilot',
      'Kaiser-Yang/blink-cmp-avante',
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
            local session = ms.session.get()
            if session == nil then
              -- Case 1:  No session. Exit insert mode.
            elseif
              R.any(
                session.nodes,
                ---@param node Node
                function(node) return node_is_tabstop(node) and node_under_cursor(node) end
              )
            then
              -- Case 2:  Session exists, and cursor under node.
              --          if cmp menu exists,  close it,
              --          otherwise,           Exit insert mode.
              return require('blink.cmp').hide()
            else
              -- Case 3:  Session exists, and cursor not under node.
              --          Stop the session and exit insert mode.
              vim.schedule(function() ms.session.stop() end)
            end
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
        default = { 'copilot', 'avante', 'lsp', 'path', 'snippets', 'buffer' },

        providers = {
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
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
