vim.g.mapleader = " "
vim.g.python3_host_prog = "$HOME/ucee/venv/bin/python3"
vim.o.termguicolors = true
vim.o.syntax = "on"
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.showmode = false
vim.bo.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("config") .. "/undodir"
vim.o.undofile = true
vim.o.incsearch = true
vim.o.hidden = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false
require("plugins")
require("config/keymappings")
