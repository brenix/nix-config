local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Mappings
vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")

-- Attach function
local on_attach = function(client, bufnr)
  local buf_opt = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local buf_map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap=true, silent=true}
  buf_map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_map('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
    augroup lsp_format
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.formatting_seq_sync()
    augroup END
    ]], false)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_highlight
      autocmd!
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end
end

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = false,
  }
)

vim.fn.sign_define(
  "LspDiagnosticsSignError",
  {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)

-- Symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

local DATA_PATH = vim.fn.stdpath('data')

-- shell script
if not configs.bashls then
  configs.bashls = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "sh", "zsh" },
      cmd = {DATA_PATH .. "/lsp_servers/bash/node_modules/.bin/bash-language-server", "start"},
    },
  }
end
lspconfig.bashls.setup{}

-- css
if not configs.cssls then
  configs.cssls = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "css" },
      cmd = {
        "node", DATA_PATH .. "/lsp_servers/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
        "--stdio"
      },
    },
  }
end
lspconfig.cssls.setup{}

-- docker
if not configs.dockerls then
  configs.dockerls = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "dockerfile" },
      cmd = {DATA_PATH .. "/lsp_servers/dockerfile/node_modules/.bin/docker-langserver", "--stdio"},
      root_dir = vim.loop.cwd,
    },
  }
end
lspconfig.dockerls.setup{}

-- go
if not configs.gopls then
  configs.gopls = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "go" },
      cmd = {DATA_PATH .. "/lsp_servers/go/gopls"},
      settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
      root_dir = lspconfig.util.root_pattern(".git","go.mod"),
      init_options = {usePlaceholders = true, completeUnimported = true},
    },
  }
end
lspconfig.gopls.setup{}

-- html
if not configs.html then
  configs.html = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "html" },
      cmd = {"node", DATA_PATH .. "/lsp_servers/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js", "--stdio"},
    },
  }
end
lspconfig.html.setup{}

-- json
if not configs.jsonls then
  configs.jsonls = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "json" },
      cmd = {
        "node", DATA_PATH .. "/lsp_servers/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
        "--stdio"
      },
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
          end
        }
      },
    },
  }
end
lspconfig.jsonls.setup{}

-- nix
if not configs.rnix then
  configs.rnix = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "nix" },
    },
  }
end
lspconfig.rnix.setup{}

-- -- lua
-- local sumneko_root_path = DATA_PATH .. "/lsp_servers/sumneko_lua/extension/server/bin/Linux"
-- local sumneko_binary = sumneko_root_path .. "/lua-language-server"
--
-- if not configs.sumneko_lua then
--   configs.sumneko_lua = {
--     default_config = {
--       cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--       on_attach = on_attach,
--       settings = {
--         Lua = {
--           runtime = {
--             version = 'LuaJIT',
--             -- Setup your lua path
--             path = vim.split(package.path, ';')
--           },
--           diagnostics = {
--             -- Get the language server to recognize the `vim` global
--             globals = {'vim'},
--             disable = {'undefined-global'}
--           },
--           workspace = {
--             -- Make the server aware of Neovim runtime files
--             library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
--             maxPreload = 10000
--           }
--         }
--       },
--     },
--   }
-- end
-- lspconfig.sumneko_lua.setup{}

-- python
if not configs.pyright then
  configs.pyright = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "python" },
      cmd = {DATA_PATH .. "/lsp_servers/python/node_modules/.bin/pyright-langserver", "--stdio"},
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true;
            useLibraryCodeForTypes = true;
            diagnosticMode = 'workspace';
          }
        }
      }
    },
  }
end
lspconfig.pyright.setup{}

-- terraform
if not configs.terraformls then
  configs.terraformls = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "tf", "terraform", "hcl" },
      cmd = {DATA_PATH .. "/lsp_servers/terraform/terraform-ls/terraform-ls", "serve"},
      root_dir = lspconfig.util.root_pattern("main.tf",".")
    },
  }
end
lspconfig.terraformls.setup{}

-- yaml
if not configs.yamlls then
  configs.yamlls = {
    default_config = {
      on_attach = on_attach,
      filetypes = { "yaml" },
      cmd = {DATA_PATH .. "/lsp_servers/yaml/node_modules/.bin/yaml-language-server", "--stdio"},
      settings = {
        yaml = {
          validate = false,
          schemaStore = {
            url = "https://json.schemastore.org/schema-catalog.json",
            enable = true
          },
          schemas = {
            kubernetes = '/*.yaml',
            ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
            ['http://json.schemastore.org/helmfile'] = 'helmfile.{yml,yaml}',
            ['http://json.schemastore.org/gitlab-ci'] = '/*lab-ci.{yml,yaml}',
            ['http://json.schemastore.org/ansible-role-2.9'] = 'roles/tasks/*.{yml,yaml}',
            ['http://json.schemastore.org/ansible-playbook'] = 'playbook.{yml,yaml}',
          }
        }
      }
    },
  }
end
lspconfig.yamlls.setup{}
