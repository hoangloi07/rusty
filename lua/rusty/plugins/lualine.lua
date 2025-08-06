local colors = require('rusty.colors').get()

return function(config)
  local bg_color = config.transparent and 'NONE' or colors.background

  return {
    normal = {
      a = { fg = colors.background, bg = colors.blue, gui = "bold" },
      b = { fg = colors.foreground, bg = colors.background },
      c = { fg = colors.foreground, bg = bg_color },
    },
    insert = {
      a = { fg = colors.background, bg = colors.green, gui = "bold" },
      b = { fg = colors.foreground, bg = colors.background },
      c = { fg = colors.foreground, bg = bg_color },
    },
    visual = {
      a = { fg = colors.background, bg = colors.purple, gui = "bold" },
      b = { fg = colors.foreground, bg = colors.background },
      c = { fg = colors.foreground, bg = bg_color },
    },
    replace = {
      a = { fg = colors.background, bg = colors.red, gui = "bold" },
      b = { fg = colors.foreground, bg = colors.background },
      c = { fg = colors.foreground, bg = bg_color },
    },
    command = {
      a = { fg = colors.background, bg = colors.orange, gui = "bold" },
      b = { fg = colors.foreground, bg = colors.background },
      c = { fg = colors.foreground, bg = bg_color },
    },
    inactive = {
      a = { fg = colors.background, bg = colors.line, gui = "bold" },
      b = { fg = colors.foreground, bg = colors.background },
      c = { fg = colors.foreground, bg = bg_color },
    },
  }
end
