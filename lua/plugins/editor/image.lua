---@module 'snacks'

local typst_template = [[
#import "@preview/whalogen:0.3.0": ce
#import "@preview/fancy-units:0.1.1": qty, unit

#set page(width: auto, height: auto, margin: (x: 1pt, y: 0pt))
#show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
#set text(size: 12pt, fill: rgb("${color}"))

#let ub(it) = { $upright(bold(it))$ }
#let xx = $times$

#let height-grid(height: 100pt, body) = {
  let body_height = measure(body).height

  if body_height <= 16pt {
    return box(height: height, align(horizon, body))
  }

  let lines = calc.ceil(body_height / height)

  box(height: height * lines, align(horizon, body))
}

#context height-grid(height: 12pt)[
  ${header}
  ${content}
]
]]

return {
  {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
      image = {
        enabled = true,
      },
    },
  },
}
