---@module 'cmp'
---@module 'avante'

return {
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
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    ---@type avante.Config
    opts = {
      -- add any opts here
      provider = 'copilot',
      auto_suggestions_provider = 'copilot',

      copilot = {
        -- model = 'claude-3.7-sonnet',
        model = 'gpt-4o',
      },

      behaviour = {
        -- enable_claude_text_editor_tool_mode = true,
      },

      file_selector = 'fzf',
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = vim.fn.has('unix') == 1 and 'make' or 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      -- 'echasnovski/mini.pick', -- for file_selector provider mini.pick
      -- 'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      -- 'echasnovski/mini.pick', -- for file_selector provider mini.pick
      -- 'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      -- 'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      -- 'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      -- {
      --   -- support for image pasting
      --   'HakonHarnes/img-clip.nvim',
      --   event = 'VeryLazy',
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   'MeanderingProgrammer/render-markdown.nvim',
      --   opts = {
      --     file_types = { 'markdown', 'Avante' },
      --   },
      --   ft = { 'markdown', 'Avante' },
      -- },
    },
  },
}
