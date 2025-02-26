# rusty.nvim

![rusty](./rusty.png)

## Features

- Supports Treesitter, LSP & Lualine
- Neovim terminal colours

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
"armannikoyan/rusty"
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use "namrabtw/rusty.nvim"
```

## Usage

### lazy.nvim

```lua
return {
	"armannikoyan/rusty",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		italic_comments = true,
		underline_current_line = true,
	},
	config = function(_, opts)
		require("rusty").setup(opts)
		vim.cmd("colorscheme rusty")
	end,
}
```

### packer.nvim

```lua
-- In Lua
vim.cmd([[colorscheme rusty]])

-- Alternatively
require("rusty").load()
```

## Lualine

```lua
theme = require("rusty").lualine
```
