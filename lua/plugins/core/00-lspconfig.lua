---@type LazyPluginSpec[]
return {
  {
    -- Manages LSP servers, DAP adapters, linters, and formatters.
    'mason-org/mason.nvim',
    lazy = false,
    priority = 1001,
    opts = {},
  },
  {
    -- Simplifies LSP server configuration with community-maintained defaults.
    'neovim/nvim-lspconfig',
    lazy = false,
  },
  {
    -- Connects mason.nvim with nvim-lspconfig, simplifying server setup.
    -- Provides mappings between mason names and lsp names
    'mason-org/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      automatic_enable = true,
    },
  },
  {
    -- Declaratively installs tools via mason.nvim.
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    opts = { ensure_installed = {} },
    opts_extend = { 'ensure_installed' },
  },
}
