local indent = 2

vim.opt.autochdir = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backspace = "indent,eol,start"
vim.opt.backup = false
vim.opt.conceallevel = 0
vim.opt.copyindent = true
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " " }
vim.opt.hidden = true
vim.opt.ignorecase = false
vim.opt.joinspaces = false
vim.opt.linebreak = false
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.shortmess = "sI"
vim.opt.smartcase = true
vim.opt.smartindent = false
vim.opt.smarttab = true
vim.opt.softtabstop = indent
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = indent
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 400
vim.opt.undofile = false
vim.opt.updatetime = 250
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest:full"
vim.opt.wrap = false

require("core.utils").set_augroup("set_formatoptions", {
  { "BufEnter", "*", string.format('lua vim.bo.formatoptions = "%s"', "cqrjt") },
})
