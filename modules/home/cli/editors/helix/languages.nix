{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.cli.editors.helix;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      deno
      golangci-lint-langserver
      gopls
      helm-ls
      # lua-language-server
      marksman
      nil
      bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.yaml-language-server
      pyright
      # terraform-ls
    ];

    programs.helix.languages = {
      language-server = {
        vscode-json-language-server = {
          command = "${pkgs.nodePackages.vscode-json-languageserver-bin}/bin/json-languageserver";
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
            command = "${pkgs.shfmt}/bin/shfmt";
            args = [
              "-i"
              "2"
              "-ci"
            ];
          };
        }
        {
          name = "go";
          auto-format = true;
          formatter = {
            command = "${pkgs.gotools}/bin/goimports";
            args = [
              "-local"
              "github.com/core"
            ];
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
            command = "${pkgs.nodePackages.fixjson}/bin/fixjson";
          };
        }
        {
          name = "markdown";
          auto-format = true;
          formatter = {
            command = "${pkgs.deno}/bin/deno";
            args = [
              "fmt"
              "-"
              "--ext"
              "md"
            ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            # command = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
            command = "${pkgs.alejandra}/bin/alejandra";
            # command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
        }
        {
          name = "python";
          language-servers = ["pyright"];
          auto-format = true;
          formatter = {
            command = "${pkgs.black}/bin/black";
            args = [
              "--quiet"
              "-"
            ];
          };
        }
      ];
    };
  };
}
