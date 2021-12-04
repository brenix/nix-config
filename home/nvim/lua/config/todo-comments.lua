require('todo-comments').setup()

-- Toggle Todo quick fix
vim.api.nvim_set_keymap('n', '<leader>t', ':TodoQuickFix<CR>', {noremap = true, silent = true})
