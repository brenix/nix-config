require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      { "filename" },
      { "lsp_progress" },
    },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = { "nvim-tree", "quickfix" },
})
