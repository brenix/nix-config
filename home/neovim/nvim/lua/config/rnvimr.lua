-- Toggle rnvimr
vim.api.nvim_set_keymap('n', '-', ':RnvimrToggle<CR>', {noremap = true, silent = true})

-- Hide popup after picking a file
vim.g.rnvimr_enable_picker = 1
