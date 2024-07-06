local o = vim.opt
local cmd = vim.cmd
local api = vim.api

local themename = "rose-pine-dawn"
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
hl("StatusLine", { bg = nil, link='Normal' })
hl('StatuslineNC', {bg=nil, link = 'Normal'})
hl("NormalFloat", { ctermfg = "LightGrey", bg = nil })
hl("WinBar", { bg = nil, bold = true })
hl("WinBarNC", { bg = nil, bold = false })

WinBar = '%f%m%r%q%y%=#[%l,%c] %L|%P  '
WinbarActive = false
o.winbar = ''


o.ch = 1
o.showmode = true
o.showcmd= true

o.laststatus = 0
vim.opt.statusline = string.rep('─', vim.api.nvim_win_get_width(0))
