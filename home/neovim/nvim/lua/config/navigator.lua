-- Configuration
require('Navigator').setup({
  auto_save = 'current',
  disable_on_zoom = true
})

-- Keybindings
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
vim.api.nvim_set_keymap('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
vim.api.nvim_set_keymap('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
vim.api.nvim_set_keymap('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
vim.api.nvim_set_keymap('n', "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
vim.api.nvim_set_keymap('n', "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
vim.api.nvim_set_keymap('n', "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
vim.api.nvim_set_keymap('n', "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
