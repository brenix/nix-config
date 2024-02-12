{ config, lib, ... }:
with lib;
let
  cfg = config.modules.terminals.alacritty;
  inherit (config.colorscheme) palette;
in
{
  options.modules.terminals.alacritty = {
    enable = mkEnableOption "enable alacritty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        scrolling.history = 10000;
        scrolling.multiplier = 3;

        shell = {
          program = "fish";
        };

        window = {
          padding = {
            x = 8;
            y = 6;
          };
          dimensions = {
            columns = 140;
            lines = 50;
          };
          decorations = "none";
        };

        selection = {
          save_to_clipboard = true;
        };

        mouse = {
          bindings = [
            {
              mouse = "Right";
              action = "PasteSelection";
            }
          ];
        };

        env = {
          TERM = "xterm-256color";
        };

        font = {
          normal = {
            family = lib.mkDefault config.my.settings.fonts.monospace;
            style = "Regular";
          };
          bold = {
            family = lib.mkDefault config.my.settings.fonts.monospace;
            style = "Regular";
          };
          italic = {
            family = lib.mkDefault config.my.settings.fonts.monospace;
            style = "Italic";
          };
          size = lib.mkDefault 11.5;
          offset.y = -1;
        };

        colors = {
          draw_bold_text_with_bright_colors = false;
          primary = {
            background = "#${palette.base00}";
            foreground = "#${palette.base05}";
            dim_foreground = "#${palette.base05}";
            bright_foreground = "#${palette.base05}";
          };
          cursor = {
            text = "#${palette.base00}";
            cursor = "#${palette.base06}";
          };
          vi_mode_cursor = {
            text = "#${palette.base00}";
            cursor = "#${palette.base07}";
          };
          search = {
            matches = {
              foreground = "#${palette.base00}";
              background = "#${palette.base0C}";
            };
            focused_match = {
              foreground = "#${palette.base00}";
              background = "#${palette.base0B}";
            };
          };
          hints = {
            start = {
              foreground = "#${palette.base00}";
              background = "#${palette.base0A}";
            };
            end = {
              foreground = "#${palette.base00}";
              background = "#${palette.base0C}";
            };
          };
          selection = {
            text = "#${palette.base00}";
            background = "#${palette.base06}";
          };
          normal = {
            black = "#${palette.base02}";
            red = "#${palette.base08}";
            green = "#${palette.base0B}";
            yellow = "#${palette.base0A}";
            blue = "#${palette.base0D}";
            magenta = "#${palette.base0E}";
            cyan = "#${palette.base0C}";
            white = "#${palette.base05}";
          };
          bright = {
            black = "#${palette.base03}";
            red = "#${palette.base08}";
            green = "#${palette.base0B}";
            yellow = "#${palette.base0A}";
            blue = "#${palette.base0D}";
            magenta = "#${palette.base0E}";
            cyan = "#${palette.base0C}";
            white = "#${palette.base06}";
          };
          dim = {
            black = "#${palette.base02}";
            red = "#${palette.base08}";
            green = "#${palette.base0B}";
            yellow = "#${palette.base0A}";
            blue = "#${palette.base0D}";
            magenta = "#${palette.base0E}";
            cyan = "#${palette.base0C}";
            white = "#${palette.base05}";
          };
          indexed_colors = [
            {
              index = 16;
              color = "#EF9F76";
            }
            {
              index = 17;
              color = "#${palette.base06}";
            }
          ];
        };
      };
    };
  };

}
