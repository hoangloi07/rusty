-- Rusty
-- https://github.com/namrabtw
--
-- Modified version of:
-- Tomorrow Night - Full Colour and 256 Colour
-- http://chriskempson.com
--
-- Hex colour conversion functions borrowed from the theme "Desert256"

-- Save this as lua/rusty/init.lua
local M = {}

local config = {
    transparent = false,
    italic_comments = true,
    underline_current_line = false,
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

-- Apply highlights
local function apply_highlight(group, fg, bg, attr)
    local cmd = "highlight " .. group
    if fg then cmd = cmd .. " guifg=#" .. fg .. " ctermfg=" .. hex_to_cterm(fg) end
    if bg and not config.transparent then cmd = cmd .. " guibg=#" .. bg .. " ctermbg=" .. hex_to_cterm(bg) end
    if attr then cmd = cmd .. " gui=" .. attr .. " cterm=" .. attr end
    vim.cmd(cmd)
end

-- Apply the color scheme
function M.apply()
    local c = config.colors
    apply_highlight("Normal", c.foreground, config.transparent and "NONE" or c.background)
    apply_highlight("Comment", c.comment, nil, config.italic_comments and "italic" or nil)
    -- Add more highlights as needed
end

return M
