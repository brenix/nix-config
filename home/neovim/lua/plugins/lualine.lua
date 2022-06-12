local colors = {
  -- black = "#000000",
  black = "#161821",
  black1 = "#191C26",
  black2 = "#2E3440",
  black3 = "#3B4252",
  green = "#809575",
  white = "#ECEFF4",
  gray = "#AEB3BB",
  magenta = "#8C738C",
  blue = "#68809A",
  yellow = "#B29E75",
  red = "#94545D",
  cyan = "#6D96A5",
}

local nord_dark = {
  normal = {
    a = { fg = colors.black, bg = colors.blue },
    b = { fg = colors.gray, bg = colors.black2 },
    c = { fg = colors.black3, bg = colors.black1 },
  },

  insert = { a = { fg = colors.black, bg = colors.green } },
  visual = { a = { fg = colors.black, bg = colors.magenta } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require("lualine").setup({
  options = {
    theme = "gruvbox-material",
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
