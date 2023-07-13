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
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.fixjson
    nodePackages.markdownlint-cli
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.yaml-language-server
    nil
    terraform-ls
    lua-language-server
    marksman

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

  programs.helix = {
    enable = true;

    settings = {
      theme = colorscheme.slug;

      editor = {
        color-modes = true;
        line-number = "absolute";
        indent-guides.render = true;
        soft-wrap = { enable = false; };
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = true;
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
        C = [ "extend_to_line_end" "delete_selection" "insert_mode" ];
        D = [ "extend_to_line_end" "delete_selection" ];
        G = "goto_file_end";
        P = [ "paste_clipboard_before" "collapse_selection" ];
        d.d = [ "extend_to_line_bounds" "delete_selection" ];
        d.t = [ "extend_till_char" "delete_selection" ];
        d.w = [ "move_next_word_start" "delete_selection" ];
        minus = "file_picker";
        p = [ "paste_clipboard_after" "collapse_selection" ];
        space."/" = "toggle_comments";
        space.Q = ":q!";
        space.W = ":w!";
        space.f = ":format";
        space.minus = ":hsplit-new";
        space.q = ":q";
        space.space = "file_picker";
        space.v = ":vsplit-new";
        space.w = ":w";
        x = "delete_selection";
        y.y = [ "extend_to_line_bounds" "yank_main_selection_to_clipboard" "normal_mode" "collapse_selection" ];
      };

      keys.insert = {
        esc = [ "collapse_selection" "normal_mode" ];
      };
    };

    themes = import ./theme.nix { inherit colorscheme; };

    languages = with pkgs; {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
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
      ];
    };
  };
}
