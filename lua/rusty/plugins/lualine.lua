local colors = require('rusty.colors').get()

return {
  normal = {
    a = { fg = colors.background, bg = colors.blue, gui = "bold" },
    b = { fg = colors.foreground, bg = colors.line },
    c = { fg = colors.foreground, bg = colors.background },
  },
  insert = {
    a = { fg = colors.background, bg = colors.green, gui = "bold" },
    b = { fg = colors.foreground, bg = colors.line },
    c = { fg = colors.foreground, bg = colors.background },
  },
  visual = {
    a = { fg = colors.background, bg = colors.purple, gui = "bold" },
    b = { fg = colors.foreground, bg = colors.line },
    c = { fg = colors.foreground, bg = colors.background },
  },
  replace = {
    a = { fg = colors.background, bg = colors.red, gui = "bold" },
    b = { fg = colors.foreground, bg = colors.line },
    c = { fg = colors.foreground, bg = colors.background },
  },
  command = {
    a = { fg = colors.background, bg = colors.orange, gui = "bold" },
    b = { fg = colors.foreground, bg = colors.line },
    c = { fg = colors.foreground, bg = colors.background },
  },
  inactive = {
    a = { fg = colors.background, bg = colors.line, gui = "bold" },
    b = { fg = colors.foreground, bg = colors.line },
    c = { fg = colors.foreground, bg = colors.background },
  },
}
