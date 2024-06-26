{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.editors.helix;
in {
  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  options.cli.editors.helix = with types; {
    enable = mkBoolOpt false "enable helix editor";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "hx";
      COLORTERM = "truecolor";
    };

    programs.helix = {
      enable = true;
      catppuccin.enable = false;
      settings = {
        theme = "gruvbox_material_dark_hard";
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
          soft-wrap = {
            enable = false;
          };
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
            center = ["file-name"];
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
          D = [
            "extend_to_line_end"
            "delete_selection"
          ];
          G = "goto_file_end";
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
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
          esc = [
            "collapse_selection"
            "normal_mode"
          ];
          "C-space" = "completion";
        };
      };
    };
  };
}
