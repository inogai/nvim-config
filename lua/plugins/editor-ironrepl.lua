return {
  {
    'Vigemus/iron.nvim',
    cmd = 'IronRepl',
    main = 'iron.core',
    opts = function(_, opts)
      return {
        config = {
          repl_open_cmd = require('iron.view').right(60),
          visibility = require('iron.visibility').focus,

          repl_definition = {
            javascript = {
              command = { 'bun', 'repl' },
              block_deviders = { '\n' },
            },
          },
        },
        highlight = {},
      }
    end,
    -- stylua: ignore
    keys = {
      -- { "<leader>df", function() require("iron.core").send_file() end, desc = "Iron File" },
      -- { "<leader>dd", function() require("iron.core").send_line() end, desc = "Iron Line" },
      -- { "<leader>dp", function() require("iron.core").send_paragraph() end, desc = "Iron Paragraph" },
      { "<leader>dd", function() require("iron.core").send_until_cursor() end, desc = "Iron Above" },
      { "<leader>d", function() require("iron.core").visual_send() end, desc = "Iron Visual", mode = "v" },
    },
  },
}
