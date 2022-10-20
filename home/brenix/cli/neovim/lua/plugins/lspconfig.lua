local nvim_lsp = require("lspconfig")

local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
	if msg:match("exit code") then
		return
	end
	if log_level == vim.log.levels.ERROR then
		vim.api.nvim_err_writeln(msg)
	else
		vim.api.nvim_echo({ { msg } }, true, {})
	end
end

local on_attach = function(client, bufnr)
	require("lsp-format").on_attach(client)

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "ge", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

-- use default server configurations
local default_servers = {
	"bashls",
	"dockerls",
	"gopls",
	"rnix",
	"pyright",
}

for _, lsp in ipairs(default_servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

-- lua
nvim_lsp["sumneko_lua"].setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "on_attach" },
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- terraform
nvim_lsp["terraformls"].setup({
	on_attach = on_attach,
	root_dir = nvim_lsp.util.root_pattern("main.tf", "."),
})

-- css
nvim_lsp["jsonls"].setup({
	on_attach = on_attach,
	cmd = { "css-languageserver", "--stdio" },
})

-- html
nvim_lsp["jsonls"].setup({
	on_attach = on_attach,
	cmd = { "html-languageserver", "--stdio" },
})

-- json
nvim_lsp["jsonls"].setup({
	on_attach = on_attach,
	cmd = { "json-languageserver", "--stdio" },
})

-- yaml
nvim_lsp["yamlls"].setup({
	on_attach = on_attach,
	settings = {
		yaml = {
			validate = false,
			schemaStore = {
				url = "https://json.schemastore.org/schema-catalog.json",
				enable = true,
			},
			schemas = {
				["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/master-standalone-strict/all.json"] = "*.yaml",
				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				["http://json.schemastore.org/helmfile"] = "helmfile.{yml,yaml}",
				["http://json.schemastore.org/gitlab-ci"] = "/*lab-ci.{yml,yaml}",
				["http://json.schemastore.org/ansible-role-2.9"] = "roles/tasks/*.{yml,yaml}",
				["http://json.schemastore.org/ansible-playbook"] = "playbook.{yml,yaml}",
			},
		},
	},
})

local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	-- Go
	b.formatting.gofmt,
	b.formatting.goimports.with({
		extra_args = { "-local", "gitlab" }, -- Separate local gitlab imports from 3rd party ones
	}),
	-- Nix
	b.formatting.nixfmt.with({
		command = "nixpkgs-fmt",
	}),
	b.diagnostics.statix,
	-- Shell
	b.formatting.shfmt.with({
		extra_args = { "-i", "2", "-ci" },
	}),
	-- b.formatting.shellharden,
	-- Terraform
	b.formatting.terraform_fmt,
	b.formatting.trim_whitespace,
	-- Markdown
	b.diagnostics.markdownlint,
	-- Lua
	b.formatting.stylua,
	-- JSON5
	b.formatting.fixjson,
	-- Deno
	b.formatting.deno_fmt,
}

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})
