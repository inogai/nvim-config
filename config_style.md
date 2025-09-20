<!-- AI-AGENT-NOTE: This document provides strict guidelines for managing this Neovim configuration. Adhere to these rules to ensure consistency and maintainability. -->

# Configuration Style Guide

This repository contains the configuration for the Neovim text editor. This style guide outlines the conventions and best practices for writing and maintaining the configuration files in this project.

## 1. Directory Structure

Plugin configurations are organized by functionality into categories within the `lua/plugins/` directory.

| Category      | Description                                                    | Example Plugin |
| :------------ | :------------------------------------------------------------- | :------------- |
| `core`        | Essential plugins for fundamental features                     | `lspconfig`    |
| `ai`          | AI-related plugins                                             | `avante`       |
| `buffer`      | Plugins enhancing the current buffer (e.g., auto-pairs)        | `mini.pairs`   |
| `ui`          | Plugins that provide new windows or UI elements (e.g., file explorers) | `yazi.nvim`    |
| `lang`        | Language-specific plugins (e.g., syntax, indent)               | `markdown`     |
| `lsp`         | Plugins related to the Language Server Protocol (LSP)          | `cspell`       |
| `misc`        | Miscellaneous plugins that do not fit into other categories    | `chezmoi`      |
| `ui-heirline` | Plugins related to the status line UI                          | `heirline`     |

## 2. File Naming Conventions

- Each plugin configuration file is located in a category directory (e.g., `lua/plugins/core/`).
- Filenames **must** be prefixed with a two-digit number to control the loading order.

**Example:** `lua/plugins/core/00-lspconfig.lua`

## 3. Plugin Specification

Each plugin configuration file **must** return a table of `LazyPluginSpec` objects.

```lua
---@type LazyPluginSpec[]
return {
  {
    -- A descriptive comment explaining the plugin's purpose.
    'owner/repo',
    -- Lazy-loading options
    lazy = false,
    -- Lifecycle and configuration
    opts = {},
    -- Key mappings
    keys = {},
  },
}
```

### Field Order

Fields within each plugin specification **must** follow this exact order to maintain consistency.

1. **Descriptive Comment**: A comment explaining the plugin's purpose.
2. **Repository String**: The plugin's repository location (e.g., `'owner/repo'`).
3. **Lazy-Loading Options**: Fields like `lazy`, `event`, `cmd`, `ft`.
4. **Lifecycle & Configuration**: Fields like `init`, `opts_extend`, `opts`, `config`.
5. **Key Mappings**: The `keys` table.

## 4. Lua Coding Style

- **Formatting**: All Lua files **must** be formatted using `stylua`. The configuration is defined in `stylua.toml`.
- **Variable Naming**: Use `snake_case` for local variables and `PascalCase` for module names or classes.
- **Comments**: Use `---@type` annotations for type safety and clarity.

## Summary for AI Agents

1. **Plugin Path**: Place new plugin files in the correct category under `lua/plugins/`.
2. **File Naming**: Prefix every new plugin file with a two-digit number (e.g., `05-new-plugin.lua`).
3. **Field Order**: Strictly follow the specified field order in plugin definitions.
4. **Formatting**: Always format Lua code with `stylua`.
5. **Comments**: Add a descriptive comment for every new plugin.
