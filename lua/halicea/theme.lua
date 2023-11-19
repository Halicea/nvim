vim.o.background = "dark"
local themename = "nord"
local present, _ = pcall(require, themename)
if present then
    vim.cmd("colorscheme " .. themename)
end
local function hgh(key, val)
    vim.api.nvim_set_hl(0, key, val)
end

hgh("WinSeparator", { fg = "LightGray", bg = nil })
hgh("Normal", { bg = nil, ctermbg = nil })
hgh("SignColumn", { bg = nil })
hgh("ColorColumn", { bg = nil })
hgh("MsgArea", { bg = nil })
hgh("StatusLine", { bg = nil })
hgh("NormalFloat", { ctermfg = "LightGrey", bg = nil })
