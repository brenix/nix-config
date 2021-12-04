-- setup telescope
require('telescope').setup{
  defaults = {
    prompt_prefix = "▶ ",
    selection_caret = "▶ ",
  },
  extensions = {
    project = {
      base_dirs = {
        {path = '~/work', max_depth = 2},
        {path = '~/.dotfiles'},
      }
    }
  },
}

-- load extensions
require('telescope').load_extension('project')

-- mappings
local opt = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>p", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<C-p>", [[<Cmd>lua require('telescope').extensions.project.project{}<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fm", [[<Cmd> Neoformat<CR>]], opt)
