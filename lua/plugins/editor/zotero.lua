-- Better BibTeX integration

local function choose_cite()
  local format = 'pandoc'

  if vim.bo.filetype:match('.*tex') then
    format = 'citep'
  elseif vim.bo.filetype == 'typst' then
    format = 'typst'
  end

  local api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format=' .. format .. '&brackets=1'
  local ref = vim.fn.system('curl -s ' .. vim.fn.shellescape(api_call))
  return ref
end

local function ZoteroCite()
  local ref = choose_cite()
  if ref ~= '' then
    vim.api.nvim_put({ ref }, 'c', true, true)
  end
end

vim.api.nvim_create_user_command('ZoteroCite', ZoteroCite, { desc = 'Insert Zotero citation' })
vim.api.nvim_set_keymap('n', '<leader>z', '<Cmd>ZoteroCite<CR>', { noremap = true, silent = true })

return {}
