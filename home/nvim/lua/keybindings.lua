-- Helper to create mappings with noremap set by default
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Write/quit
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>W', ':wq<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>Q', ':q!<CR>')

-- Edit file
map('n', '<leader>e', ':e <C-R>=expand("%:p:h") . "/"<CR>')

-- Buffers
map('n', '<leader>x', ':BufDel<CR>', {silent = true})
map('n', '<leader>X', ':BufDel!<CR>', {silent = true})

-- Splits
map('n', '<leader>s', ':split<CR>', {silent = true})
map('n', '<leader>S', ':new<CR>', {silent = true})
map('n', '<leader>v', ':vsplit<CR>', {silent = true})
map('n', '<leader>V', ':vnew<CR>', {silent = true})

-- Toggle line numbers
map('n', '<leader>l', ':set invnumber<CR>', {silent = true})

-- Un-indent using shift-tab
map('i', '<S-Tab>', '<C-D>')

-- Use tab to indent visual blocks
map('v', '<Tab>', '>gv', {silent = true})
map('v', '<S-Tab>', '<gv', {silent = true})

-- Toggle search highlight
map('n', '<Leader>h', ':nohlsearch<cr>', {silent = true})
