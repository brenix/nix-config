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

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

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
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
        ["http://json.schemastore.org/gitlab-ci"] = { "/.gitlab/*.yml", "/.gitlab-ci.yml" },
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
