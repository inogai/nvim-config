return {
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

  {
    'nvim-mini/mini.pairs',
    event = { 'InsertEnter' },
    opts = {
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_unbalanced = true,
      markdown = true,
    },
  },
}
