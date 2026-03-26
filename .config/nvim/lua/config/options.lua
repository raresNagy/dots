vim.opt.ignorecase = true
vim.o.smartcase = true


vim.opt.expandtab = true-- Convert tabs to spaces
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.number = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.relativenumber = true
vim.opt.smartindent = true

vim.opt.clipboard:append("unnamedplus")

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.g.autoformat = false
vim.b.autoformat = false

-- Enable undo/redo changes even after closing and reopening a file
vim.opt.undofile = true

-- Line number on cursor
vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars:append("trail:·")

vim.opt.mouse = "a"

vim.opt.signcolumn = "yes"

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

