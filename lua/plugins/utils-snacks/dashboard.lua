---@param cwd string
---@return function
local function pick_file(cwd)
  return function() Snacks.dashboard.pick('files', { cwd = cwd }) end
end

---@type snacks.dashboard.Config
return {
  enabled = true,
  debug = false,

  width = 60,
  row = nil, -- dashboard position. nil for center
  col = nil, -- dashboard position. nil for center
  pane_gap = 4, -- empty columns between vertical panes
  autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence

  preset = {
    pick = nil,
    -- Used by the `keys` section to show keymaps.
    -- Set your custom keymaps here.
    -- When using a function, the `items` argument are the default keymaps.
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.dashboard.pick("files")' },
      -- { icon = '󱞂 ', key = 'o', desc = 'Daily Notes', action = 'ObsidianToday' },
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.dashboard.pick("live_grep")' },
      { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick("oldfiles")' },
      { icon = ' ', key = 'c', desc = 'Config', action = pick_file(vim.fn.stdpath('config')) },
      { icon = '󰇘 ', key = 'd', desc = 'Dotfiles', action = pick_file('~/.local/share/chezmoi') },
      { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
      { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
  },

  formats = {
    icon = function(item)
      if item.file and item.icon == 'file' or item.icon == 'directory' then
        return Snacks.dashboard.icon(item.file, item.icon)
      end
      return { item.icon, width = 2, hl = 'icon' }
    end,
    footer = { '%s', align = 'center' },
    header = { '%s', align = 'center' },
    file = function(item, ctx)
      local fname = vim.fn.fnamemodify(item.file, ':~')
      fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
      if #fname > ctx.width then
        local dir = vim.fn.fnamemodify(fname, ':h')
        local file = vim.fn.fnamemodify(fname, ':t')
        if dir and file then
          file = file:sub(-(ctx.width - #dir - 2))
          fname = dir .. '/…' .. file
        end
      end
      local dir, file = fname:match('^(.*)/(.+)$')
      return dir and { { dir .. '/', hl = 'dir' }, { file, hl = 'file' } } or { { fname, hl = 'file' } }
    end,
  },

  sections = {
    {
      pane = 1,
      {
        section = 'terminal',
        cmd = vim.fn.stdpath('config') .. '/asciiart/random.sh ' .. vim.o.background,
        height = 18,
        width = 40,
        padding = 1,
      },
      -- {
      --   section = "terminal",
      --   cmd = [[curl -fsSL https://international.v1.hitokoto.cn | jq -Mcr '[.hitokoto,.from,.from_who] | join(" ")' | awk '{print"『"$1"』—— "$2" "$3}']],
      -- },
    },

    {
      pane = 2,
      { section = 'keys', gap = 1, padding = 1 },
      { section = 'startup' },
    },
  },
}
