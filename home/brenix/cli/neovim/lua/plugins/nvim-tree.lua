require("nvim-tree").setup({
  auto_reload_on_write = true,
  open_on_tab = false,
  open_on_setup = false,
  update_cwd = false,
  respect_buf_cwd = true,
  reload_on_bufenter = true,
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
      quit_on_open = true,
      resize_window = true,
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", ".cache" },
  },
  view = {
    adaptive_size = true,
    preserve_window_proportions = true,
    width = 40,
  },
})
