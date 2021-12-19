local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	b.formatting.gofmt,
	b.formatting.goimports,
	b.formatting.nixfmt,
	b.formatting.prettier,
	b.formatting.shfmt.with({
		extra_args = { "-i", "2", "-ci" },
	}),
	-- b.formatting.shellharden,
	b.formatting.stylua,
	b.formatting.terraform_fmt,
	b.formatting.trim_whitespace,
}

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})
