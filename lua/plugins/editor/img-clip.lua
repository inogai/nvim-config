return {
  {
    -- support for image pasting
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = true,
        drag_and_drop = {
          insert_mode = true,
        },
        -- required for Windows users
        use_absolute_path = false,
      },
    },

    filetypes = {
      typst = {
        use_absolute_path = false,
        relative_to_current_file = true,
      },
    },
  },
}
