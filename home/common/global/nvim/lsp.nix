{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Language servers
    gopls
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.fixjson
    nodePackages.markdownlint-cli
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.yaml-language-server
    # python3Packages.python-lsp-server
    nil
    terraform-ls

    # Formatters
    deno
    gotools
    nixpkgs-fmt
    python3Packages.mdformat
    reftools
    shellharden
    shfmt
    stylua

    # Diagnostics
    golangci-lint
    statix

  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    lsp_signature-nvim
    lspkind-nvim
    lualine-lsp-progress
    {
      plugin = lsp-format-nvim;
      type = "lua";
      config = /* lua */ ''
        require("lsp-format").setup{}

        -- format synchronously when using :wq
        vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
      '';
    }
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = /* lua */ ''
        local lspconfig = require('lspconfig')
        local on_attach = function(client, bufnr)
          require("lsp-format").on_attach(client)
          require("lsp_signature").on_attach(signature_setup, bufnr)
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          if vim.bo[bufnr].filetype == "helm" then
            vim.diagnostic.disable()
            vim.defer_fn(function()
              vim.diagnostic.reset(nil, bufnr)
            end, 1000)
          end
        end

        function add_lsp(binary, server, options)
          if vim.fn.executable(binary) == 1 then server.setup({on_attach = on_attach, options}) end
        end

        add_lsp("bash-language-server", lspconfig.bashls, {})
        add_lsp("docker-langserver", lspconfig.dockerls, {})
        add_lsp("gopls", lspconfig.gopls, {})
        add_lsp("pylsp", lspconfig.pylsp, {})
        add_lsp("nil", lspconfig.nil_ls, {})
        add_lsp("terraform-ls", lspconfig.terraformls, {})
        --add_lsp("yaml-language-server", lspconfig.yamlls, {
        --  settings = {
        --    yaml = {
        --      validate = false,
        --      schemaStore = {
        --        url = "https://json.schemastore.org/schema-catalog.json",
        --        enable = true,
        --      },
        --      schemas = {
        --        ["https://json.schemastore.org/kustomization"] = "/kustomization.{yml,yaml}",
        --        ["https://json.schemastore.org/helmfile"] = "/helmfile.{yml,yaml}",
        --        ["https://json.schemastore.org/gitlab-ci"] = "/.gitlab*.yml",
        --        ["https://json.schemastore.org/ansible-role-2.9"] = "roles/tasks/*.{yml,yaml}",
        --        ["https://json.schemastore.org/ansible-playbook"] = "/playbook.{yml,yaml}",
        --        ["https://json.schemastore.org/taskfile.json"] = "/Taskfile*.yml",
        --        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.13/all.json"] = "/*.yaml",
        --      },
        --    },
        --  },
        --})
      '';
    }
    {
      plugin = null-ls-nvim;
      type = "lua";
      config = /* lua */ ''
        local null_ls = require("null-ls")
        local b = null_ls.builtins
        local sources = {
          -- Go
          b.diagnostics.golangci_lint,
          b.formatting.gofmt,
          b.formatting.goimports,
          -- Nix
          b.formatting.nixfmt.with({
            command = "nixpkgs-fmt",
          }),
          b.diagnostics.statix,
          -- Shell
          b.formatting.shfmt.with({
            extra_args = { "-i", "2", "-ci" },
          }),
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
      '';
    }
  ];
}