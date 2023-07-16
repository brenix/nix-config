{ config, pkgs, ... }:
let
  inherit (config) colorscheme;
in
{
  home.sessionVariables.EDITOR = "hx";

  home.sessionVariables.COLORTERM = "truecolor";

  home.packages = with pkgs; [
    # Language servers
    gopls
    lua-language-server
    marksman
    nil
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.yaml-language-server
    python3Packages.python-lsp-server
    terraform-ls

    # Formatters
    gotools
    nixpkgs-fmt
  ];

  programs.helix = {
    enable = true;

    settings = {
      # theme = colorscheme.slug;
      theme = "github_light";

      editor = {
        color-modes = true;
        line-number = "absolute";
        indent-guides.render = true;
        soft-wrap = { enable = false; };
        cursor-shape = {
          normal = "block";
          # insert = "bar";
          insert = "block";
          select = "underline";
        };
        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = false;
          snippets = true;
        };
        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-name" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
        };
      };

      keys.normal = {
        "$" = "goto_line_end";
        "^" = "goto_first_nonwhitespace";
        D = [ "extend_to_line_end" "delete_selection" ];
        G = "goto_file_end";
        minus = "file_picker";
        space.Q = ":q!";
        space.W = ":w!";
        space.f = ":format";
        space.minus = ":hsplit-new";
        space.q = ":q";
        space.space = "file_picker";
        space.v = ":vsplit-new";
        space.w = ":w";
      };

      keys.insert = {
        esc = [ "collapse_selection" "normal_mode" ];
      };
    };

    themes = import ./theme.nix { inherit colorscheme; };

    languages = with pkgs; {
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
          };
        }
        {
          name = "json";
          auto-format = true;
          language-server = {
            command = "${nodePackages.vscode-json-languageserver-bin}/bin/json-languageserver";
            args = [ "--stdio" ];
          };
          formatter = {
            command = "${nodePackages.fixjson}/bin/fixjson";
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
        }
      ];
    };
  };
}
