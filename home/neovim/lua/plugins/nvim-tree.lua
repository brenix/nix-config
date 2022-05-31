-- Options
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_width = 25
vim.g.nvim_tree_allow_resize = 1

require("nvim-tree").setup({
	open_on_tab = false,
	open_on_setup = false,
	update_cwd = false,
	respect_buf_cwd = true,
	renderer = {
    root_folder_modifier = ":~",
    highlight_git = true,
    special_files = { "" },
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	filters = {
		dotfiles = false,
		custom = { ".git", "node_modules", ".cache" },
	},
	view = {
		width = 35,
	},
})
