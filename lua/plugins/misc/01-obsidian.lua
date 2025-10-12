local path_to_my_vault = vim.fn.expand('~') .. '/Documents/Obsidian'

---@param note obsidian.Note
---@return table<string, any>
local frontmatter_func = function(note)
  local now = os.date('%Y-%m-%d')
  local out = {
    id = note.id,
    title = note.title,
    description = '',
    aliases = note.aliases,
    tags = note.tags,
    created = now,
    updated = '',
  }

  out = vim.tbl_deep_extend('force', out, note.metadata or {})
  out.updated = now
  return out
end

return {
  {
    -- This plugin provides integration between Neovim and Obsidian.md
    'inogai/obsidian.nvim',
    event = {
      'BufReadPre ' .. path_to_my_vault .. '/*.md',
      'BufNewFile ' .. path_to_my_vault .. '/*.md',
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      frontmatter = {
        enabled = true,
        func = frontmatter_func,
        sort = { 'id', 'title', 'description', 'aliases', 'tags', 'created', 'updated' },
      },
      legacy_commands = false,
      ui = { enable = false }, -- in flavour of render-markdown.nvim
      workspaces = {
        {
          name = 'v2',
          path = path_to_my_vault .. '/v2',
        },
      },
    },
  },
}
