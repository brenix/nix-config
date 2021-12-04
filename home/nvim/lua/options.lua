local indent = 2

vim.opt.autochdir = true
vim.opt.autoindent = false
vim.opt.autoread = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.backup = false
vim.opt.conceallevel = 0
vim.opt.copyindent = true
vim.opt.expandtab = true
vim.opt.joinspaces = false
vim.opt.hidden = true
vim.opt.linebreak = false
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.shortmess = 'aFc'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = indent
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = indent
vim.opt.termguicolors = true
vim.opt.undofile = false
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest:full'
vim.opt.wrap = false

require('utils').set_augroup(
  'set_formatoptions', {
    { 'BufEnter', '*', string.format('lua vim.bo.formatoptions = "%s"', 'cqrjt') }
  }
)
