-- General settings
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 80
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ttyfast = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"

-- UI and colors
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")
vim.g.gruvbox_contrast_light = "hard"
vim.g.solarized_termcolors = 256
vim.g.rehash256 = 1
