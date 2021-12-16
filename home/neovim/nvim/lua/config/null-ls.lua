local _, null_ls = pcall(require, "null-ls")

local b = null_ls.builtins

local sources = {
  b.formatting.gofmt,
  b.formatting.goimports,
  b.formatting.nixfmt,
  b.formatting.prettier,
  b.formatting.shellharden,
  b.formatting.shfmt.with({
    extra_args = { "-i", "2", "-ci" }
  }),
  b.formatting.stylua,
  b.formatting.terraform_fmt,
  b.formatting.trim_whitespace,
}

local null_ls = require("null-ls")

null_ls.setup({
  sources = sources,
  on_attach = on_attach,
})

vim.api.nvim_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", { noremap = true, silent = true })
