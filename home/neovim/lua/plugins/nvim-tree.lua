-- Options
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_width = 25
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.nvim_tree_allow_resize = 1
vim.g.nvim_tree_special_files = { "" }
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_root_folder_modifier = table.concat({ ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" })

require("nvim-tree").setup({
	auto_close = false,
	open_on_tab = false,
	open_on_setup = true,
	update_cwd = false,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	filters = {
		dotfiles = false,
		custom = { ".git", "node_modules", ".cache" },
	},
	view = {
		auto_resize = true,
		width = 35,
		preserve_window_proportions = true,
	},
})
