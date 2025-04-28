-- Rusty
-- https://github.com/namrabtw
--
-- Modified version of:
-- Tomorrow Night - Full Colour and 256 Colour
-- http://chriskempson.com
--
-- Hex colour conversion functions borrowed from the theme "Desert256"

local M = {}
local colors = require('rusty.colors')

local function require_relative(path)
  local script_path = debug.getinfo(1, "S").source:sub(2)
  local dir = vim.fn.fnamemodify(script_path, ":p:h")
  package.path = string.format("%s;%s/../../?.lua", package.path, dir)
end

require_relative()  -- Set up paths
M.lualine = require('plugins.lualine')

-- Default configuration
local config = {
	transparent = false,  -- Enable/disable transparency
	italic_comments = true,  -- Enable/disable italic comments
	underline_current_line = false,  -- Enable/disable underline for current line
}

-- Setup user configuration
function M.setup(user_config)
  user_config = user_config or {}  -- Add this line to handle nil case
  config = vim.tbl_deep_extend("force", config, user_config)
  colors.setup((user_config or {}).colors or {})  -- Safe access
  M.apply()
end

-- Convert hex to cterm color
local function hex_to_cterm(hex)
  if hex == "NONE" then return "NONE" end
	local r = tonumber(hex:sub(2, 3), 16)
	local g = tonumber(hex:sub(4, 5), 16)
	local b = tonumber(hex:sub(6, 7), 16)
	return math.floor((r * 36 + g * 6 + b) / 51)
end

-- Apply highlights for various groups
local function apply_highlight(group, fg, bg, attr)
  fg = fg and fg or "NONE"
  bg = bg and bg or "NONE"
  attr = attr and attr or {}
  vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", {
    fg = fg, ctermfg = hex_to_cterm(fg),
    bg = bg, ctermbg = hex_to_cterm(bg),
  }, attr))
end

-- Apply all the necessary highlights for Vim
function M.apply()
  local c = colors.get()

	-- Basic highlights
	apply_highlight("Normal", c.foreground, config.transparent and nil or c.background)
	apply_highlight("NormalFloat", c.foreground, c.background)
	apply_highlight("LineNr", c.selection, nil)
	apply_highlight("NonText", c.selection, nil)
	apply_highlight("SpecialKey", c.selection, nil)
	apply_highlight("Search", c.background, c.yellow)
	apply_highlight("TabLine", c.foreground, c.background, { reverse = true })
	apply_highlight("StatusLine", c.yellow, c.background, nil)
	apply_highlight("StatusLineNC", c.window, c.foreground, { reverse = true })
	apply_highlight("VertSplit", c.window, c.window, nil)
	apply_highlight("Visual", nil, c.selection)
	apply_highlight("Directory", c.blue, nil)
	apply_highlight("ModeMsg", c.green, nil)
	apply_highlight("MoreMsg", c.green, nil)
	apply_highlight("Question", c.green, nil)
	apply_highlight("WarningMsg", c.red, nil)
	apply_highlight("MatchParen", nil, c.selection)
	apply_highlight("Folded", c.comment, c.background)
	apply_highlight("FoldColumn", nil, c.background)
	apply_highlight("CursorLine", nil, config.underline_current_line and c.line or nil, nil)
	apply_highlight("CursorColumn", nil, nil, nil)
	apply_highlight("PMenu", c.foreground, c.selection, nil)
	apply_highlight("PMenuSel", c.foreground, c.selection, { reverse = true })
	apply_highlight("SignColumn", nil, nil, nil)
	apply_highlight("ColorColumn", nil, nil, nil)

	-- Syntax highlights
	apply_highlight("Type", c.orange, nil)
	apply_highlight("Comment", c.comment, nil, config.italic_comments and { italic = true } or nil)
	apply_highlight("Todo", c.comment, c.background)
	apply_highlight("Title", c.comment, nil)
	apply_highlight("Identifier", c.purple, nil, nil)
	apply_highlight("Statement", c.purple, nil)
	apply_highlight("Function", c.foreground, nil)
	apply_highlight("Constant", c.orange, nil)
	apply_highlight("Character", c.yellow, nil)
	apply_highlight("String", c.green, nil)
	apply_highlight("Special", c.foreground, nil)
	apply_highlight("PreProc", c.orange, nil)
	apply_highlight("Structure", c.foreground, nil, nil)
	apply_highlight("Include", c.aqua, nil)
	apply_highlight("Operator", c.foreground, nil)

	-- Vim-specific highlights
  apply_highlight("VimCommand", c.red, nil, nil)
	apply_highlight("@namespace", c.foreground, nil, nil)
	apply_highlight("@function", c.aqua, nil, nil)

	-- LSP highlights
	apply_highlight("@lsp.type.function", c.aqua, nil, nil)
	apply_highlight("@lsp.type.variable", c.foreground, nil, nil)
	apply_highlight("@lsp.type.struct", c.orange, nil, nil)
	apply_highlight("@lsp.type.namespace", c.foreground, nil, nil)
	apply_highlight("@lsp.type.enumMember", c.foreground, nil, nil)

	-- Diff highlights
	local diffbackground = "#494e56"
	apply_highlight("diffAdded", c.green, nil)
	apply_highlight("diffRemoved", c.red, nil)
	apply_highlight("DiffAdd", c.green, diffbackground)
	apply_highlight("DiffDelete", c.red, diffbackground)
	apply_highlight("DiffChange", c.yellow, diffbackground)
	apply_highlight("DiffText", diffbackground, c.orange)

	-- ShowMarks highlights
	apply_highlight("ShowMarksHLl", c.orange, c.background, nil)
	apply_highlight("ShowMarksHLo", c.purple, c.background, nil)
	apply_highlight("ShowMarksHLu", c.yellow, c.background, nil)
	apply_highlight("ShowMarksHLm", c.aqua, c.background, nil)
end

return M
