local o = vim.opt
local cmd = vim.cmd
local api = vim.api

o.background = "dark"
local themename = "tokyonight-storm"
--
-- o.background = "light"
-- local themename = "newpaper"

local present, _ = pcall(require, themename)
if present then
    cmd("colorscheme " .. themename)
end
local function hl(key, val)
    api.nvim_set_hl(0, key, val)
end

hl("WinSeparator", { fg = "LightGray", bg = nil })
hl("Normal", { bg = nil, ctermbg = nil })
hl("SignColumn", { bg = nil })
hl("ColorColumn", { bg = nil })
hl("MsgArea", { bg = nil })
hl("StatusLine", { bg = nil })
hl("NormalFloat", { ctermfg = "LightGrey", bg = nil })
hl("WinBar", { bg = nil, bold = true })
hl("WinBarNC", { bg = nil, bold = false })

o.winbar='%f\\ %y%m'
o.ls = 0
o.ch = 0
o.laststatus=3
o.showmode = true
o.showcmd= true
