local o = vim.opt
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
o.termguicolors=true
o.exrc = true
o.number = false
o.relativenumber = false
o.hlsearch = false
o.hidden = true
o.tabstop=4
o.softtabstop=4
o.shiftwidth=4
o.expandtab=true
o.smartindent=true
o.wrap = false
o.smartcase=true

o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.incsearch = true
o.scrolloff = 8
o.linebreak = true
o.showmode = false
o.showcmd=false

o.completeopt = "menuone,noinsert,noselect"
o.signcolumn = "yes"
o.colorcolumn = "80"
o.cmdheight = 1
o.updatetime = 50
o.shortmess:append("c")

o.timeoutlen = 500
o.laststatus=3
o.syntax = "on"

o.foldcolumn = "0"
o.foldlevel = 99
o.foldenable = false
o.foldmethod = "indent"

o.list=true
o.listchars:append({eol="↵"})
o.conceallevel = 2
o.concealcursor = "nc"
o.cmdheight=0

o.winbar='%f\\ %y%m'
o.ls = 0
o.ch = 0
o.laststatus=3

