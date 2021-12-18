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
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>W", ":wq<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>Q", ":q!<CR>")
map("n", "<leader>e", ':e <C-R>=expand("%:p:h") . "/"<CR>')
map("n", "<leader>x", ":BufDel<CR>", { silent = true })
map("n", "<leader>X", ":BufDel!<CR>", { silent = true })
map("n", "<leader>s", ":split<CR>", { silent = true })
map("n", "<leader>S", ":new<CR>", { silent = true })
map("n", "<leader>v", ":vsplit<CR>", { silent = true })
map("n", "<leader>V", ":vnew<CR>", { silent = true })
map("n", "<leader>l", ":set invnumber<CR>", { silent = true })
map("i", "<S-Tab>", "<C-D>")
map("v", "<Tab>", ">gv", { silent = true })
map("v", "<S-Tab>", "<gv", { silent = true })
map("n", "<Leader>h", ":nohlsearch<cr>", { silent = true })

-- formatting
map("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", { silent = true })

-- bufferline
map("n", "<Tab>", [[<Cmd>BufferLineCycleNext<CR>]], { silent = true })
map("n", "<S-Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], { silent = true })

-- comment
map("n", "<leader>'", ":CommentToggle<CR>", { silent = true })
map("v", "<leader>'", ":CommentToggle<CR>", { silent = true })

-- git-blame
map("n", "<leader>g", ":GitBlameToggle<CR>", { silent = true })

-- indentline
map("n", "<leader>i", ":IndentBlanklineToggle<CR>", { silent = true })

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
map("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true })

-- rnvimr
map("n", "-", ":RnvimrToggle<CR>", { silent = true })

-- telescope
map("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { silent = true })
map("n", "<Leader>p", [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { silent = true })
map("n", "<C-p>", [[<Cmd>lua require('telescope').extensions.project.project{}<CR>]], { silent = true })
map("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], { silent = true })
map("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], { silent = true })
map("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], { silent = true })
map("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], { silent = true })

-- todo-comments
map("n", "<leader>t", ":TodoQuickFix<CR>", { silent = true })
