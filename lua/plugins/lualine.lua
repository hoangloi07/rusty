local colors = require('rusty.colors').get()

require('lualine').setup({
  options = {
    theme = {
      normal = {
        a = { fg = config.colors.background, bg = config.colors.blue, gui = "bold" },
        b = { fg = config.colors.foreground, bg = config.colors.line },
        c = { fg = config.colors.foreground, bg = config.colors.background },
      },
      insert = {
        a = { fg = config.colors.background, bg = config.colors.green, gui = "bold" },
        b = { fg = config.colors.foreground, bg = config.colors.line },
        c = { fg = config.colors.foreground, bg = config.colors.background },
      },
      visual = {
        a = { fg = config.colors.background, bg = config.colors.purple, gui = "bold" },
        b = { fg = config.colors.foreground, bg = config.colors.line },
        c = { fg = config.colors.foreground, bg = config.colors.background },
      },
      replace = {
        a = { fg = config.colors.background, bg = config.colors.red, gui = "bold" },
        b = { fg = config.colors.foreground, bg = config.colors.line },
        c = { fg = config.colors.foreground, bg = config.colors.background },
      },
      command = {
        a = { fg = config.colors.background, bg = config.colors.orange, gui = "bold" },
        b = { fg = config.colors.foreground, bg = config.colors.line },
        c = { fg = config.colors.foreground, bg = config.colors.background },
      },
      inactive = {
        a = { fg = config.colors.background, bg = config.colors.line, gui = "bold" },
        b = { fg = config.colors.foreground, bg = config.colors.line },
        c = { fg = config.colors.foreground, bg = config.colors.background },
      },
    },
  },
})
