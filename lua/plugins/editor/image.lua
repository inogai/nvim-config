---@module 'snacks'

return {
  {
    'inogai/snacks.nvim',
    ---@type snacks.Config
    opts = {
      image = {
        doc = {
          enable = true,
          max_width = 80,
          max_height = 10,
        },
        convert = {
          magick = {
            math = { '-density', 192, '{src}[0]' },
          },
        },
        math = {
          typst = {
            tpl = [[
            #set page(width: auto, height: auto, margin: (x: 1pt, y: 2pt))
            #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
            #set text(size: 12pt, fill: rgb("${color}"))
            ${header}
            ${content}]],
          },
        },
      },
    },
  },
}
