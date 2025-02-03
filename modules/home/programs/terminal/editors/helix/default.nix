{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.editors.helix;
in {
  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  options.${namespace}.programs.terminal.editors.helix = {
    enable = mkBoolOpt false "enable helix editor";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "hx";
      COLORTERM = "truecolor";
    };

    programs.helix = {
      enable = true;
      # catppuccin.enable = true;
      themes = with config.lib.stylix.colors.withHashtag; {
        stylix = {
          "attributes" = base09;
          "comment" = {
            fg = base03;
            modifiers = ["italic"];
          };
          "constant" = base09;
          "constant.character.escape" = base0C;
          "constant.numeric" = base09;
          "constructor" = base08;
          "debug" = base03;
          "diagnostic" = {modifiers = ["underlined"];};
          "diagnostic.error" = {underline = {style = "curl";};};
          "diagnostic.hint" = {underline = {style = "curl";};};
          "diagnostic.info" = {underline = {style = "curl";};};
          "diagnostic.warning" = {underline = {style = "curl";};};
          "diff.delta" = base09;
          "diff.minus" = base08;
          "diff.plus" = base0B;
          "error" = base0D;
          "function" = base08;
          "hint" = base03;
          "info" = base08;
          "keyword" = base0E;
          "label" = base0E;
          "markup.bold" = {
            fg = base0A;
            modifiers = ["bold"];
          };
          "markup.heading" = base08;
          "markup.italic" = {
            fg = base0E;
            modifiers = ["italic"];
          };
          "markup.link.text" = base0D;
          "markup.link.url" = {
            fg = base09;
            modifiers = ["underlined"];
          };
          "markup.list" = base0D;
          "markup.quote" = base0C;
          "markup.raw" = base0B;
          "markup.strikethrough" = {modifiers = ["crossed_out"];};
          "namespace" = base0E;
          "operator" = base05;
          "special" = base08;
          "string" = base0B;
          "type" = base0A;
          "ui.background" = {bg = base00;};
          "ui.bufferline" = {
            fg = base03;
            bg = base00;
          };
          "ui.bufferline.active" = {
            fg = base05;
            bg = base02;
            modifiers = ["bold"];
          };
          "ui.cursor" = {
            fg = base04;
            modifiers = ["reversed"];
          };
          "ui.cursor.insert" = {
            fg = base0A;
            modifiers = ["underlined"];
          };
          "ui.cursor.match" = {
            fg = base0A;
            modifiers = ["underlined"];
          };
          "ui.cursor.select" = {
            fg = base0A;
            modifiers = ["underlined"];
          };
          "ui.cursorline.primary" = {
            fg = base05;
            bg = base01;
          };
          "ui.gutter" = {bg = base00;};
          "ui.help" = {
            fg = base06;
            bg = base01;
          };
          "ui.linenr" = {
            fg = base03;
            bg = base00;
          };
          "ui.linenr.selected" = {
            fg = base04;
            bg = base01;
            modifiers = ["bold"];
          };
          "ui.menu" = {
            fg = base05;
            bg = base01;
          };
          "ui.menu.scroll" = {
            fg = base03;
            bg = base01;
          };
          "ui.menu.selected" = {
            fg = base01;
            bg = base04;
          };
          "ui.popup" = {bg = base01;};
          "ui.selection" = {bg = base02;};
          "ui.selection.primary" = {bg = base02;};
          "ui.statusline" = {
            fg = base04;
            bg = base01;
          };
          "ui.statusline.inactive" = {
            bg = base01;
            fg = base02;
          };
          "ui.statusline.insert" = {
            fg = base00;
            bg = base0B;
          };
          "ui.statusline.normal" = {
            fg = base00;
            bg = base08;
          };
          "ui.statusline.select" = {
            fg = base00;
            bg = base0E;
          };
          "ui.text" = base05;
          "ui.text.focus" = base05;
          "ui.virtual.indent-guide" = {fg = base03;};
          "ui.virtual.ruler" = {bg = base01;};
          "ui.virtual.whitespace" = {fg = base01;};
          "ui.window" = {bg = base01;};
          # "variable" = base0D;
          "variable" = base05;
          "variable.other.member" = base0D;
          "warning" = base09;
        };
      };

      settings = {
        theme = "everforest_dark_hard";
        editor = {
          auto-pairs = false;
          bufferline = "always";
          undercurl = true;
          color-modes = true;
          completion-replace = true;
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
            select = "block";
          };
          gutters = [
            "diagnostics"
            "line-numbers"
            "spacer"
            "diff"
          ];
          idle-timeout = 1;
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
          rulers = [80];
          scrolloff = 5;
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
