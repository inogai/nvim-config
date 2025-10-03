# Lsp Configuration for Neovim

## Rule 1: vim.lsp.enable()

Since `automatic_enable = true` is now set in `../core/00-lspconfig.lua`, you
need not to call `vim.lsp.enable()` in your LSP configuration files.

## Rule 2: Ensure installed

Use `Utils.ts_ensure_installed()` and `Utils.mason_ensure_installed()` to ensure
that the relevant LSP servers, linters, and formatters are installed.
