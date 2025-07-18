local function longest_head_slice(text, pattern)
  for i = #text, 1, -1 do
    local head = pattern:sub(1, i)
    if text:find(head, 1, true) then return head end
  end

  return nil
end

local function select_accept_and_dedup_pairs()
  local blink = require('blink.cmp')
  local completion_list = require('blink.cmp.completion.list')
  local selected_item = blink.get_selected_item() or completion_list[1]

  return blink.select_and_accept({
    callback = function()
      local textEdit = selected_item and selected_item.textEdit
      if textEdit == nil then return end

      local end_pos = textEdit.range['end']
      -- Trailing end pairs
      local after_text = vim.api.nvim_buf_get_text(
        0,
        end_pos.line,
        end_pos.character,
        end_pos.line,
        end_pos.character + 99,
        {}
      )[1]
      after_text = string.match(after_text, '[\')}>"%]]')
      if after_text == nil then return end

      -- Identify the end pair existence in the textEdit.newText
      local match = longest_head_slice(textEdit.newText, after_text)
      if match == nil then return end
      vim.api.nvim_buf_set_text(
        0,
        end_pos.line,
        end_pos.character,
        end_pos.line,
        end_pos.character + #match,
        { '' }
      )
    end,
  })
end

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
  if node.text ~= nil then offset = #node.text end

  if cursor[1] == extmark[1] and cursor[2] >= extmark[2] and cursor[2] <= extmark[2] + offset then
    return true
  end

  return false
end

---@type table<string, blink.cmp.SourceProviderConfigPartial>
local providers = {
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

return {
  {
    'echasnovski/mini.snippets',
    version = '*',
    config = function()
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup({
        snippets = {
          -- Load custom file with global snippets first
          gen_loader.from_file('~/.config/nvim/snippets/global.json'),

          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          gen_loader.from_lang(),
        },
      })
    end,
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      copilot_model = 'gpt-4o-copilot',
    },
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
            components = { kind_icon = kind_icon },
          },
        },
      },

      snippets = { preset = 'mini_snippets' },
      keymap = {
        preset = 'none',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-n>'] = { 'snippet_forward' },
        ['<C-l>'] = { select_accept_and_dedup_pairs, 'fallback' },
        ['<Tab>'] = { 'snippet_forward', select_accept_and_dedup_pairs },
        ['<Esc>'] = {
          function()
            local ms = require('mini.snippets')
            local session = ms.session.get()
            if session == nil then
              -- Case 1:  No session. Exit insert mode.
            elseif
              vim
                .iter(session.nodes)
                :any(function(node) return node_is_tabstop(node) and node_under_cursor(node) end)
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
        providers = providers,
      },
    },
  },
}
