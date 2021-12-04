local _, null_ls = pcall(require, "null-ls")

local b = null_ls.builtins

local sources = {
  b.formatting.prettier,
  b.formatting.shfmt.with({
    extra_args = { "-i", "2", "-ci" }
  }),
  b.formatting.goimports,
  b.formatting.gofmt,
  b.formatting.stylua,
  b.formatting.terraform_fmt,
}

null_ls.config({ sources = sources })

require("lspconfig")["null-ls"].setup({ on_attach = on_attach })

vim.api.nvim_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", { noremap = true, silent = true })
