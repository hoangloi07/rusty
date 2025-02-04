local M = {}

local colors = {
  foreground = "#c5c8c6",
  background = "#1d1f21",
  selection = "#373b41",
  line = "#282a2e",
  comment = "#969896",
  red = "#cc6666",
  orange = "#de935f",
  yellow = "#f0c674",
  green = "#b5bd68",
  aqua = "#8abeb7",
  blue = "#81a2be",
  purple = "#b294bb",
  window = "#4d5057",
}

M.theme = {
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
    a = { fg = colors.foreground, bg = colors.line, gui = "bold" },
    b = { fg = colors.foreground, bg = colors.line },
    c = { fg = colors.foreground, bg = colors.background },
  },
}

return M
