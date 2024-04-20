{ pkgs
, ...
}:
{
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
    languages = with pkgs; {
      language-server = {
        vscode-json-language-server = {
          command = "${nodePackages.vscode-json-languageserver-bin}/bin/json-languageserver";
          args = [ "--stdio" ];
        };
      };
      language = [
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = "${shfmt}/bin/shfmt";
            args = [ "-i" "2" "-ci" ];
          };
        }
        {
          name = "go";
          auto-format = true;
          formatter = {
            command = "${gotools}/bin/goimports";
            args = [ "-local" "gitlab.eng" ];
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
            args = [ "fmt" "-" "--ext" "md" ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
        }
        {
          name = "python";
          language-servers = [ "pyright" ];
          auto-format = true;
          formatter = {
            command = "${black}/bin/black";
            args = [ "--quiet" "-" ];
          };
        }
      ];
    };
  };
}
