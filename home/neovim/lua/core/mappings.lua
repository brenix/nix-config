-- Helper to create mappings with noremap set by default
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
map("n", "<Leader>w", ":w<CR>")
map("n", "<Leader>W", ":wq<CR>")
map("n", "<Leader>q", ":q<CR>")
map("n", "<Leader>Q", ":q!<CR>")
map("n", "<Leader>e", ':e <C-R>=expand("%:p:h") . "/"<CR>')
map("n", "<Leader>x", ":BufDel<CR>", { silent = true })
map("n", "<Leader>X", ":BufDel!<CR>", { silent = true })
map("n", "<Leader>s", ":split<CR>", { silent = true })
map("n", "<Leader>S", ":new<CR>", { silent = true })
map("n", "<Leader>v", ":vsplit<CR>", { silent = true })
map("n", "<Leader>V", ":vnew<CR>", { silent = true })
map("n", "<Leader>l", ":set invnumber<CR>", { silent = true })
map("i", "<S-Tab>", "<C-D>")
map("v", "<Tab>", ">gv", { silent = true })
map("v", "<S-Tab>", "<gv", { silent = true })
map("n", "<Leader>h", ":nohlsearch<cr>", { silent = true })

-- formatting
map("n", "<Leader>fm", "<cmd>Format()<CR>", { silent = true })

-- bufferline
map("n", "<Tab>", [[<Cmd>BufferLineCycleNext<CR>]], { silent = true })
map("n", "<S-Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], { silent = true })

-- comment
map("n", "<Leader>'", ":CommentToggle<CR>", { silent = true })
map("v", "<Leader>'", ":CommentToggle<CR>", { silent = true })

-- git-blame
map("n", "<Leader>g", ":GitBlameToggle<CR>", { silent = true })

-- indentline
map("n", "<Leader>i", ":IndentBlanklineToggle<CR>", { silent = true })

-- navigator
map("n", "<A-h>", "<CMD>lua require('Navigator').left()<CR>", { silent = true })
map("n", "<A-k>", "<CMD>lua require('Navigator').up()<CR>", { silent = true })
map("n", "<A-l>", "<CMD>lua require('Navigator').right()<CR>", { silent = true })
map("n", "<A-j>", "<CMD>lua require('Navigator').down()<CR>", { silent = true })
map("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", { silent = true })
map("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", { silent = true })
map("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", { silent = true })
map("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", { silent = true })

-- nvim-tree
map("n", "<Leader>n", ":NvimTreeToggle<CR>", { silent = true })
map("n", "-", ":NvimTreeFindFile<CR>", { silent = true })

-- telescope
map("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { silent = true })
map("n", "<Leader>p", [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { silent = true })
map("n", "<C-p>", [[<Cmd>lua require('telescope').extensions.project.project{}<CR>]], { silent = true })
map("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], { silent = true })
map("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], { silent = true })
map("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], { silent = true })
map("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], { silent = true })

-- todo-comments
map("n", "<Leader>t", ":TodoQuickFix<CR>", { silent = true })
