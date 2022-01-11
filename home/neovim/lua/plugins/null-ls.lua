local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	b.formatting.gofmt,
	b.formatting.goimports,
	b.formatting.nixfmt,
	-- HACK: Remove bracket spacing for helm template support (https://github.com/prettier/prettier/issues/6517)
	b.formatting.prettier.with({
		extra_args = { "--no-bracket-spacing" },
	}),
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
