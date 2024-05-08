{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.editors.helix;
  # inherit (config) colorscheme;
in {
  options.cli.editors.helix = with types; {
    enable = mkBoolOpt false "enable helix editor";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "hx";
      COLORTERM = "truecolor";
    };

    home.packages = with pkgs; [
      golangci-lint-langserver
      gopls
      lua-language-server
      marksman
      nil
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.pyright
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.yaml-language-server
      # terraform-ls
    ];

    programs.helix = {
      enable = true;
      catppuccin.enable = true;
      # themes = import ./theme.nix { inherit colorscheme; };
      settings = {
        editor = {
          auto-pairs = false;
          bufferline = "always";
          undercurl = true;
          color-modes = true;
          line-number = "absolute";
          indent-guides = {
            render = true;
            rainbow-option = "dim";
          };
          soft-wrap = {enable = false;};
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          file-picker = {
            hidden = false;
            parents = false;
            git-ignore = false;
          };
          lsp = {
            enable = true;
            display-messages = true;
            display-inlay-hints = false;
            snippets = true;
          };
          statusline = {
            left = [
              "mode"
              "spacer"
              "version-control"
              "spacer"
              "spinner"
            ];
            center = [
              "file-name"
            ];
            right = [
              "diagnostics"
              "position-percentage"
              "file-type"
            ];
            mode = {
              "normal" = "NORMAL";
              "insert" = "INSERT";
              "select" = "SELECT";
            };
          };
        };

        keys.normal = {
          "$" = "goto_line_end";
          "^" = "goto_first_nonwhitespace";
          D = ["extend_to_line_end" "delete_selection"];
          G = "goto_file_end";
          esc = ["collapse_selection" "keep_primary_selection"];
          minus = "file_picker_in_current_buffer_directory";
          p = "paste_clipboard_after";
          space.Q = ":q!";
          space.W = ":w!";
          space.e = "file_picker_in_current_buffer_directory";
          space.f = ":format";
          space.l = ":toggle lsp.display-inlay-hints";
          space.minus = ":hsplit-new";
          space.n = ":new";
          space.q = ":q";
          space.space = "file_picker";
          space.t = ":toggle-option auto-format";
          space.v = ":vsplit-new";
          space.w = ":w";
          space.x = ":buffer-close";
          tab = "goto_next_buffer";
          "S-tab" = "goto_previous_buffer";
          "C-h" = "jump_view_left";
          "C-j" = "jump_view_down";
          "C-k" = "jump_view_up";
          "C-l" = "jump_view_right";
          y = "yank_main_selection_to_clipboard";
        };

        keys.insert = {
          esc = ["collapse_selection" "normal_mode"];
          "C-space" = "completion";
        };
      };

      # TODO: Split these into their own development roles
      languages = with pkgs; {
        language-server = {
          vscode-json-language-server = {
            command = "${nodePackages.vscode-json-languageserver-bin}/bin/json-languageserver";
            args = ["--stdio"];
          };
          yaml-language-server = {
            config.yaml = {
              completion = true;
              validation = true;
              hover = true;
              # schemaStore.enable = true;
            };
            config.yaml.schemas = {
              # ansible tasks
              "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks" = "tasks/*.{yml,yaml}";
              # ansible playbooks
              "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook" = "*ansible*/*.{yml,yaml}";
              # kustomization
              "http://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
              # helm chart
              "http://json.schemastore.org/chart" = "Chart.{yml,yaml}";
              # helmfile
              "http://json.schemastore.org/helmfile.json" = "helmfile.{yml,yaml}";
              # gitlab-ci
              "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json" = "*gitlab-ci*.{yml,yaml}";
              # argo workflows
              "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" = "*flow*.{yml,yaml}";
              # taskfile
              "http://json.schemastore.org/taskfile.json" = "Taskfile*.{yml,yaml}";
              # kubernetes
              # "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0/all.json" = "/*.yaml";
              # github workflow
              "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
              # github actions
              "http://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
              # flux kustomization
              "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/kustomization-kustomize-v1.json" = "ks.{yml,yaml}";
              # flux helmrelease
              "https://kubernetes-schemas.pages.dev/helm.toolkit.fluxcd.io/helmrelease_v2beta2.json" = "helmrelease.{yml,yaml}";
              # externalsecrets
              "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/external-secrets.io/externalsecret_v1beta1.json" = "external*secret.{yml,yaml}";
            };
          };
        };
        language = [
          {
            name = "bash";
            auto-format = true;
            formatter = {
              command = "${shfmt}/bin/shfmt";
              args = ["-i" "2" "-ci"];
            };
          }
          {
            name = "go";
            auto-format = true;
            formatter = {
              command = "${gotools}/bin/goimports";
              args = ["-local" "gitlab.eng"];
            };
            indent = {
              tab-width = 2;
              unit = "\t";
            };
          }
          {
            name = "json";
            auto-format = true;
            formatter = {
              command = "${nodePackages.fixjson}/bin/fixjson";
            };
          }
          {
            name = "markdown";
            auto-format = true;
            formatter = {
              command = "${deno}/bin/deno";
              args = ["fmt" "-" "--ext" "md"];
            };
          }
          {
            name = "nix";
            auto-format = true;
            formatter = {
              # command = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
              command = "${alejandra}/bin/alejandra";
            };
          }
          {
            name = "python";
            language-servers = ["pyright"];
            auto-format = true;
            formatter = {
              command = "${black}/bin/black";
              args = ["--quiet" "-"];
            };
          }
        ];
      };
    };
  };
}
