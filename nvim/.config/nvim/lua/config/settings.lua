vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.ignorecase = true --ignore case while searching
vim.opt.smartcase = true --but do not ignore if caps are used
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.autoread = true

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "●",
      [severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
