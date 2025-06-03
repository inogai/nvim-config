return {
  '3rd/image.nvim',
  opts = {
    integrations = {
      neorg = {
        enabled = true,
        clear_in_insert_mode = true,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        only_render_image_at_cursor_mode = 'popup',
        floating_windows = false,
        filetypes = { 'norg' },
      },
    },
    window_overlap_clear_enabled = true,
  },
}
