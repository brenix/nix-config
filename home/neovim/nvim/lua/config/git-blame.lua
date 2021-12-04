-- Disable git blame by default
vim.g.gitblame_enabled = 0

-- Toggle git blame
vim.api.nvim_set_keymap('n', '<leader>g', ':GitBlameToggle<CR>', {noremap = true, silent = true})
