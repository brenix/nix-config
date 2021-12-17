require("telescope").setup({
	defaults = {
		prompt_prefix = "▶ ",
		selection_caret = "▶ ",
	},
	extensions = {
		project = {
			base_dirs = {
				{ path = "~/work", max_depth = 2 },
				{ path = "~/.dotfiles" },
			},
		},
	},
})

require("telescope").load_extension("project")
