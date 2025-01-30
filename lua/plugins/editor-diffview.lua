local M = { actions = {} }

---@return FileEntry?
---@return integer[]? cursor
function M.prepare_goto_file()
  local lazy = require('diffview.lazy')

  local DiffView = lazy.access('diffview.scene.views.diff.diff_view', 'DiffView') ---@type DiffView|LazyModule
  local FileHistoryView = lazy.access('diffview.scene.views.file_history.file_history_view', 'FileHistoryView') ---@type FileHistoryView|LazyModule
  local lib = lazy.require('diffview.lib') ---@module "diffview.lib"
  local utils = lazy.require('diffview.utils') ---@module "diffview.utils"
  local api = vim.api
  local pl = lazy.access(utils, 'path') ---@type PathLib

  local view = lib.get_current_view()

  if view and not (view:instanceof(DiffView.__get()) or view:instanceof(FileHistoryView.__get())) then
    return
  end

  ---@cast view DiffView|FileHistoryView

  local file = view:infer_cur_file()
  if file then
    ---@cast file FileEntry
    -- Ensure file exists
    if not pl:readable(file.absolute_path) then
      utils.err(string.format("File does not exist on disk: '%s'", pl:relative(file.absolute_path, '.')))
      return
    end

    local cursor
    local cur_file = view.cur_entry
    if file == cur_file then
      local win = view.cur_layout:get_main_win()
      cursor = api.nvim_win_get_cursor(win.id)
    end

    return file, cursor
  end
end

function M.actions.discard()
  local file, cursor = M.prepare_goto_file()

  if file == nil then
    vim.notify('No file found', vim.log.levels.ERROR)
    return
  end

  local path = require('plenary.path')

  local relative_path = path:new(file.absolute_path):make_relative(vim.fn.getcwd())

  local confirm_res = vim.fn.confirm(
    'Do you want to discard changes to ' .. relative_path .. '?',
    '&Yes\n&No\n',
    2
    --
  )

  if confirm_res == 1 then
    vim.notify('(Not) Discarded changes to ' .. relative_path)
  end
end

return {
  {
    'sindrets/diffview.nvim',

    opts = function()
      local actions = require('diffview.actions')

      local km = {
        { { 'n' }, 'q', '<Cmd>DiffviewClose<CR>', { desc = '[Q]uit Diffview' } },
      }

      vim.api.nvim_set_hl(0, 'MyDiffDeletedLines', { link = 'NonText' })
      vim.api.nvim_set_hl(0, 'MyDiffTextFrom', { bg = '#6d4443' })
      vim.api.nvim_set_hl(0, 'MyDiffChangeFrom', { bg = '#4a3433' })
      vim.api.nvim_set_hl(0, 'MyDiffTextTo', { bg = '#3a5247' })
      vim.api.nvim_set_hl(0, 'MyDiffChangeTo', { bg = '#2e3b36' })

      vim.opt.fillchars:append({ diff = '╱' })

      return {
        enhanced_diff_hl = true,

        file_panel = {
          listing_style = 'list',
          win_config = {
            width = 30,
          },
        },

        keymaps = {
          disable_defaults = false,
          view = {
            unpack(km),
          },
          file_panel = {
            { 'n', '<down>', actions.select_next_entry },
            { 'n', '<up>', actions.select_prev_entry },
            { 'n', 'j', actions.select_next_entry },
            { 'n', 'k', actions.select_prev_entry },
            { 'n', 's', actions.toggle_stage_entry },
            { 'n', 'd', M.actions.discard },
            unpack(km),
          },
          file_history_panel = {
            unpack(km),
          },
        },

        hooks = {
          -- diff_buf_read = function()
          --   vim.opt_local.wrap = false
          -- end,
          ---@diagnostic disable-next-line: unused-local
          diff_buf_win_enter = function(bufnr, winid, ctx)
            -- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
            -- the right.
            if ctx.layout_name:match('^diff2') then
              if ctx.symbol == 'a' then
                vim.opt_local.winhl = table.concat({
                  'DiffAdd:MyDiffTextFrom',
                  'DiffDelete:MyDiffDeletedLines',
                  'DiffChange:MyDiffChangeFrom',
                  'DiffText:MyDiffTextFrom',
                }, ',')
              elseif ctx.symbol == 'b' then
                vim.opt_local.winhl = table.concat({
                  'DiffAdd:MyDiffChangeTo',
                  'DiffDelete:MyDiffDeletedLines',
                  'DiffChange:MyDiffChangeTo',
                  'DiffText:MyDiffTextTo',
                }, ',')
              end
            end
          end,
        },
      }
    end,

    keys = {
      { '<leader>gg', '<cmd>DiffviewOpen<CR>', desc = 'Diffview' },
    },
  },
}
