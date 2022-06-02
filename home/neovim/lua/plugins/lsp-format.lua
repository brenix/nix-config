require("lsp-format").setup {}

-- format synchronously when using :wq
vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
