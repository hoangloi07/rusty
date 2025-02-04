" Rusty
" https://github.com/namrabtw
"
" Modified version of:
" Tomorrow Night - Full Colour and 256 Colour
" http://chriskempson.com
"
" Hex colour conversion functions borrowed from the theme "Desert256""

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

-- Merge user configuration with defaults
function M.setup(user_config)
    config = vim.tbl_deep_extend("force", config, user_config or {})
end

-- Convert hex color to cterm color
local function hex_to_cterm(hex)
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    return string.format("%d", (r * 36 + g * 6 + b) / 51)
end

-- Apply highlight groups
local function apply_highlight(group, fg, bg, attr)
    local cmd = "highlight " .. group
    if fg then cmd = cmd .. " guifg=#" .. fg .. " ctermfg=" .. hex_to_cterm(fg) end
    if bg and not config.transparent then cmd = cmd .. " guibg=#" .. bg .. " ctermbg=" .. hex_to_cterm(bg) end
    if attr then cmd = cmd .. " gui=" .. attr .. " cterm=" .. attr end
    vim.cmd(cmd)
end

-- Setup the color scheme
function M.apply()
    local c = config.colors

    -- Basic highlights
    apply_highlight("Normal", c.foreground, config.transparent and "NONE" or c.background)
    apply_highlight("LineNr", c.selection, config.transparent and "NONE" or c.background)
    apply_highlight("NonText", c.selection, config.transparent and "NONE" or c.background)
    apply_highlight("SpecialKey", c.selection, config.transparent and "NONE" or c.background)
    apply_highlight("Search", c.background, c.yellow)
    apply_highlight("TabLine", c.foreground, c.background, "reverse")
    apply_highlight("StatusLine", c.yellow, nil, "none")
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

    -- Additional highlights for specific languages
    apply_highlight("vimCommand", c.red, nil, "none")
    apply_highlight("@namespace", c.foreground, nil, "none")
    apply_highlight("@function", c.aqua, nil, "none")
    apply_highlight("@lsp.type.function", c.aqua, nil, "none")
    apply_highlight("@lsp.type.variable", c.foreground, nil, "none")
    apply_highlight("@lsp.type.struct", c.orange, nil, "none")
    apply_highlight("@lsp.type.namespace", c.foreground, nil, "none")
    apply_highlight("@lsp.type.enumMember", c.foreground, nil, "none")

    -- Diff highlights
    local diff_background = "494e56"
    apply_highlight("diffAdded", c.green, nil)
    apply_highlight("diffRemoved", c.red, nil)
    apply_highlight("DiffAdd", c.green, diff_background)
    apply_highlight("DiffDelete", c.red, diff_background)
    apply_highlight("DiffChange", c.yellow, diff_background)
    apply_highlight("DiffText", diff_background, c.orange)
end

return M
