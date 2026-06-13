-- ==============================================================================
-- Liquid Chrome - Neovim Configuration (init.lua)
-- ==============================================================================
-- A highly specific crossover between Frutiger Aero (aquatic, glass, glow) and
-- Gen X Soft Club (sterile minimalism, Y2K techno translucency, sharp geometry).
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. Neovim Global Options
-- ------------------------------------------------------------------------------
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Use relative line numbers for precise jumping
vim.opt.mouse = "a"               -- Enable mouse support
vim.opt.termguicolors = true      -- True color support (required for hex colors)
vim.opt.showmode = false          -- Hide default mode text (we have a custom statusline)
vim.opt.laststatus = 3            -- Global statusline (modern Neovim)
vim.opt.splitright = true         -- Horizontal splits open to the right
vim.opt.splitbelow = true         -- Vertical splits open below
vim.opt.cursorline = true         -- Highlight active line

-- Indentation settings
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.shiftwidth = 2            -- Number of spaces for indent
vim.opt.tabstop = 2               -- Tab width

-- ------------------------------------------------------------------------------
-- 2. Liquid Chrome Color Palette
-- ------------------------------------------------------------------------------
local colors = {
  bg = "#0B1021",          -- Deep Ambient Blue base
  bg_trans = "none",       -- Set normal text bg to none to let terminal transparency show
  fg = "#FFFFFF",          -- Pure White
  accent1 = "#00FFFF",     -- Aquatic Cyan
  accent2 = "#39FF14",     -- Bioluminescent Lime Green
  secondary = "#A0A5B5",   -- Muted Silver-Blue
  border = "#2A3554",      -- Metallic Wireframe Trim
  cursorline = "#161C33",  -- Darker blue for active line highlight
  visual = "#00FFFF",      -- Cyan for selection highlight
  comment = "#505A70"      -- Dimmed wireframe blue-gray
}

-- ------------------------------------------------------------------------------
-- 3. Custom Liquid Chrome Highlights
-- ------------------------------------------------------------------------------
local apply_highlights = function()
  -- Core Interface elements (Transparent background to let Kitty translucency shine)
  vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = colors.bg_trans })
  vim.api.nvim_set_hl(0, "NormalNC", { fg = colors.secondary, bg = colors.bg_trans })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg_trans })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.accent1, bg = colors.bg_trans })
  
  -- Active elements & Selection
  vim.api.nvim_set_hl(0, "Visual", { fg = colors.bg, bg = colors.visual })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.cursorline })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.accent1, bold = true })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.comment })
  
  -- Split bars
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.border, bold = true })
  
  -- Search & Matching
  vim.api.nvim_set_hl(0, "Search", { fg = colors.bg, bg = colors.accent2 })
  vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.bg, bg = colors.accent1 })
  vim.api.nvim_set_hl(0, "MatchParen", { fg = colors.accent2, underline = true, bold = true })
  
  -- Syntax Highlighting (Liquid Chrome Palette)
  vim.api.nvim_set_hl(0, "Comment", { fg = colors.comment, italic = true })
  vim.api.nvim_set_hl(0, "Constant", { fg = colors.accent2 })             -- String, numbers
  vim.api.nvim_set_hl(0, "String", { fg = colors.accent2 })               -- Lime green strings
  vim.api.nvim_set_hl(0, "Character", { fg = colors.accent2 })
  vim.api.nvim_set_hl(0, "Number", { fg = colors.accent2 })
  vim.api.nvim_set_hl(0, "Boolean", { fg = colors.accent2, bold = true })
  vim.api.nvim_set_hl(0, "Float", { fg = colors.accent2 })
  
  vim.api.nvim_set_hl(0, "Identifier", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "Function", { fg = colors.accent1, bold = true }) -- Cyan functions
  
  vim.api.nvim_set_hl(0, "Statement", { fg = colors.accent1 })             -- Keywords, conditionals
  vim.api.nvim_set_hl(0, "Keyword", { fg = colors.accent1 })
  vim.api.nvim_set_hl(0, "Operator", { fg = colors.accent1 })
  vim.api.nvim_set_hl(0, "PreProc", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "Type", { fg = colors.accent1, bold = true })
  vim.api.nvim_set_hl(0, "Special", { fg = colors.accent2 })
  vim.api.nvim_set_hl(0, "Underlined", { underline = true })
  vim.api.nvim_set_hl(0, "Error", { fg = "#FF2E93", bold = true })
  vim.api.nvim_set_hl(0, "Todo", { fg = colors.bg, bg = colors.accent1, bold = true })

  -- Custom StatusLine Highlights
  vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.cursorline })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.secondary, bg = colors.bg })
  vim.api.nvim_set_hl(0, "StatusLineMode", { fg = colors.bg, bg = colors.accent1, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineFile", { fg = colors.fg, bg = colors.cursorline, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineInfo", { fg = colors.secondary, bg = colors.cursorline })
end

apply_highlights()

-- Reapply highlights on colorscheme switch to prevent resets
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_highlights
})

-- ------------------------------------------------------------------------------
-- 4. Custom Statusline Layout
-- ------------------------------------------------------------------------------
local modes = {
  ["n"]  = "NORMAL",
  ["v"]  = "VISUAL",
  ["V"]  = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["i"]  = "INSERT",
  ["R"]  = "REPLACE",
  ["c"]  = "COMMAND",
  ["t"]  = "TERMINAL"
}

_G.get_current_mode = function()
  local mode_code = vim.api.nvim_get_mode().mode
  return modes[mode_code] or mode_code:upper()
end

vim.opt.statusline = "%#StatusLineMode# %{v:lua.get_current_mode()} %#StatusLineFile# %f %m %#StatusLine#%=%#StatusLineInfo# %y | %l:%c (%p%%) "
