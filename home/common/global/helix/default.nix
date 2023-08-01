{ config, pkgs, ... }:
let
  inherit (config) colorscheme;
in
{
  home.sessionVariables.EDITOR = "hx";

  home.sessionVariables.COLORTERM = "truecolor";

  home.packages = with pkgs; [
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
  ];

  programs.helix = {
    enable = true;

    settings = {
      theme = colorscheme.slug;

      editor = {
        bufferline = "always";
        undercurl = true;
        color-modes = true;
        line-number = "absolute";
        indent-guides.render = true;
        soft-wrap = { enable = false; };
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
        esc = [ "collapse_selection" "keep_primary_selection" ];
        minus = "file_picker_in_current_buffer_directory";
        p = "paste_clipboard_before";
        space.Q = ":q!";
        space.W = ":w!";
        space.e = "file_picker_in_current_buffer_directory";
        space.f = ":format";
        space.l = ":toggle lsp.display-inlay-hints";
        space.minus = ":hsplit-new";
        space.q = ":q";
        space.space = "file_picker";
        space.v = ":vsplit-new";
        space.w = ":w";
        y = "yank_main_selection_to_clipboard";
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
            args = [ "-local" "gitlab.eng" ];
          };
        }
        # {
        #   # TODO: Disable terraform LSP but keep formatting until performance issues are resolved
        #   name = "hcl";
        #   auto-format = true;
        #   language-server = {
        #     command = "";
        #   };
        # }
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
      ];
    };
  };
}
