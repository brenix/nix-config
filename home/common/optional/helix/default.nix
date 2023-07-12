{ config, pkgs, ... }:
let
  inherit (config) colorscheme;
in
{
  home.sessionVariables.EDITOR = "hx";

  home.sessionVariables.COLORTERM = "truecolor";

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
        minus = "file_picker";
        space.f = ":format";
        space.w = ":w";
        space.minus = ":hsplit-new";
        space.q = ":q";
        space.space = "file_picker";
        space.v = ":vsplit-new";
        space."/" = "toggle_comments";
      };
    };

    themes = import ./theme.nix { inherit colorscheme; };

    languages = with pkgs; {

      # language-server = {
      #   vscode-json-language-server = {
      #     command = "${nodePackages.vscode-json-languageserver-bin}/bin/json-languageserver";
      #     args = [ "--stdio" ];
      #   };
      # };

      language = [
        {
          name = "json";
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
