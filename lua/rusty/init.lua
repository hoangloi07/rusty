-- Rusty
-- https://github.com/namrabtw
--
-- Modified version of:
-- Tomorrow Night - Full Colour and 256 Colour
-- http://chriskempson.com
--
-- Hex colour conversion functions borrowed from the theme "Desert256"

local M = {}

-- Default configuration
local config = {
	transparent = false,  -- Enable/disable transparency
	italic_comments = true,  -- Enable/disable italic comments
	underline_current_line = false,  -- Enable/disable underline for current line
	colors = {
		foreground = "c5c8c6",
		background = "1d1f21",
		selection = "373b41",
		line = "282a2e",
		comment = "969896",
		red = "cc6666",
		orange = "de935f",
		yellow = "f0c674",
		green = "b5bd68",
		aqua = "8abeb7",
		blue = "81a2be",
		purple = "b294bb",
		window = "4d5057",
	}
}

local lualine = {
	normal = {
		a = { fg = "#" .. config.colors.background, bg = "#" .. config.colors.blue, gui = "bold" },
		b = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.line },
		c = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.background },
	},
	insert = {
		a = { fg = "#" .. config.colors.background, bg = "#" .. config.colors.green, gui = "bold" },
		b = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.line },
		c = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.background },
	},
	visual = {
		a = { fg = "#" .. config.colors.background, bg = "#" .. config.colors.purple, gui = "bold" },
		b = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.line },
		c = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.background },
	},
	replace = {
		a = { fg = "#" .. config.colors.background, bg = "#" .. config.colors.red, gui = "bold" },
		b = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.line },
		c = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.background },
	},
	command = {
		a = { fg = "#" .. config.colors.background, bg = "#" .. config.colors.orange, gui = "bold" },
		b = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.line },
		c = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.background },
	},
	inactive = {
		a = { fg = "#" .. config.colors.background, bg = "#" .. config.colors.line, gui = "bold" },
		b = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.line },
		c = { fg = "#" .. config.colors.foreground, bg = "#" .. config.colors.background },
	},
}

M.lualine = lualine

-- Setup user configuration
function M.setup(user_config)
	config = vim.tbl_deep_extend("force", config, user_config or {})
	M.apply() -- Automatically apply after setup
end

-- Convert hex to cterm color
local function hex_to_cterm(hex)
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)
	return string.format("%d", (r * 36 + g * 6 + b) / 51)
end

-- Apply highlights for various groups
local function apply_highlight(group, fg, bg, attr)
	local cmd = "highlight " .. group
	if fg then cmd = cmd .. " guifg=#" .. fg .. " ctermfg=" .. hex_to_cterm(fg) end
	if bg then
		if config.transparent and group == "Normal" then
			cmd = cmd .. " guibg=NONE ctermbg=NONE"
		else
			cmd = cmd .. " guibg=#" .. bg .. " ctermbg=" .. hex_to_cterm(bg)
		end
	end
	if attr then cmd = cmd .. " gui=" .. attr .. " cterm=" .. attr end
	vim.cmd(cmd)
end

-- Apply all the necessary highlights for Vim
function M.apply()
	local c = config.colors

	-- Basic highlights
	apply_highlight("Normal", c.foreground, c.background)
	apply_highlight("NormalFloat", c.foreground, c.background)
	apply_highlight("LineNr", c.selection, nil)
	apply_highlight("NonText", c.selection, nil)
	apply_highlight("SpecialKey", c.selection, nil)
	apply_highlight("Search", c.background, c.yellow)
	apply_highlight("TabLine", c.foreground, c.background, "reverse")
	apply_highlight("StatusLine", c.yellow, c.background, nil)
	apply_highlight("StatusLineNC", c.window, c.foreground, "reverse")
	apply_highlight("VertSplit", c.window, c.window, "none")
	apply_highlight("Visual", nil, c.selection)
	apply_highlight("Directory", c.blue, nil)
	apply_highlight("ModeMsg", c.green, nil)
	apply_highlight("MoreMsg", c.green, nil)
	apply_highlight("Question", c.green, nil)
	apply_highlight("WarningMsg", c.red, nil)
	apply_highlight("MatchParen", nil, c.selection)
	apply_highlight("Folded", c.comment, c.background)
	apply_highlight("FoldColumn", nil, c.background)
	apply_highlight("CursorLine", nil, config.underline_current_line and c.line or nil, "none")
	apply_highlight("CursorColumn", nil, nil, "none")
	apply_highlight("PMenu", c.foreground, c.selection, "none")
	apply_highlight("PMenuSel", c.foreground, c.selection, "reverse")
	apply_highlight("SignColumn", nil, nil, "none")
	apply_highlight("ColorColumn", nil, nil, "none")

	-- Syntax highlights
	apply_highlight("Type", c.orange, nil)
	apply_highlight("Comment", c.comment, nil, config.italic_comments and "italic" or nil)
	apply_highlight("Todo", c.comment, c.background)
	apply_highlight("Title", c.comment, nil)
	apply_highlight("Identifier", c.purple, nil, "none")
	apply_highlight("Statement", c.purple, nil)
	apply_highlight("Function", c.foreground, nil)
	apply_highlight("Constant", c.orange, nil)
	apply_highlight("Character", c.yellow, nil)
	apply_highlight("String", c.green, nil)
	apply_highlight("Special", c.foreground, nil)
	apply_highlight("PreProc", c.orange, nil)
	apply_highlight("Structure", c.foreground, nil, "none")
	apply_highlight("Include", c.aqua, nil)
	apply_highlight("Operator", c.foreground, nil)

	-- Vim-specific highlights
	apply_highlight("vimCommand", c.red, nil, "none")
	apply_highlight("@namespace", c.foreground, nil, "none")
	apply_highlight("@function", c.aqua, nil, "none")

	-- LSP highlights
	apply_highlight("@lsp.type.function", c.aqua, nil, "none")
	apply_highlight("@lsp.type.variable", c.foreground, nil, "none")
	apply_highlight("@lsp.type.struct", c.orange, nil, "none")
	apply_highlight("@lsp.type.namespace", c.foreground, nil, "none")
	apply_highlight("@lsp.type.enumMember", c.foreground, nil, "none")

	-- Diff highlights
	local diffbackground = "494e56"
	apply_highlight("diffAdded", c.green, nil)
	apply_highlight("diffRemoved", c.red, nil)
	apply_highlight("DiffAdd", c.green, diffbackground)
	apply_highlight("DiffDelete", c.red, diffbackground)
	apply_highlight("DiffChange", c.yellow, diffbackground)
	apply_highlight("DiffText", diffbackground, c.orange)

	-- ShowMarks highlights
	apply_highlight("ShowMarksHLl", c.orange, c.background, "none")
	apply_highlight("ShowMarksHLo", c.purple, c.background, "none")
	apply_highlight("ShowMarksHLu", c.yellow, c.background, "none")
	apply_highlight("ShowMarksHLm", c.aqua, c.background, "none")
end

return M
