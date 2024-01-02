{ config, lib, ... }:
with lib;
let
  cfg = config.modules.terminals.alacritty;
  inherit (config.colorscheme) colors;
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

        dynamic_padding = false;

        selection = {
          save_to_clipboard = true;
        };

        mouse_bindings = [
          {
            mouse = "Right";
            action = "PasteSelection";
          }
        ];

        env = {
          TERM = "xterm-256color";
        };

        font = {
          normal = {
            inherit (config.my.settings.fonts) monospace;
            style = "Regular";
          };
          bold = {
            inherit (config.my.settings.fonts) monospace;
            style = "Regular";
          };
          italic = {
            inherit (config.my.settings.fonts) monospace;
            style = "Italic";
          };
          size = lib.mkDefault 11.5;
          offset.y = -3;
        };

        draw_bold_text_with_bright_colors = false;
        colors = {
          primary = {
            background = "#${colors.base00}";
            foreground = "#${colors.base05}";
            dim_foreground = "#${colors.base05}";
            bright_foreground = "#${colors.base05}";
          };
          cursor = {
            text = "#${colors.base00}";
            cursor = "#${colors.base06}";
          };
          vi_mode_cursor = {
            text = "#${colors.base00}";
            cursor = "#${colors.base07}";
          };
          search = {
            matches = {
              foreground = "#${colors.base00}";
              background = "#${colors.base0C}";
            };
            focused_match = {
              foreground = "#${colors.base00}";
              background = "#${colors.base0B}";
            };
            footer_bar = {
              foreground = "#${colors.base00}";
              background = "#${colors.base0C}";
            };
          };
          hints = {
            start = {
              foreground = "#${colors.base00}";
              background = "#${colors.base0A}";
            };
            end = {
              foreground = "#${colors.base00}";
              background = "#${colors.base0C}";
            };
          };
          selection = {
            text = "#${colors.base00}";
            background = "#${colors.base06}";
          };
          normal = {
            black = "#${colors.base02}";
            red = "#${colors.base08}";
            green = "#${colors.base0B}";
            yellow = "#${colors.base0A}";
            blue = "#${colors.base0D}";
            magenta = "#${colors.base0E}";
            cyan = "#${colors.base0C}";
            white = "#${colors.base05}";
          };
          bright = {
            black = "#${colors.base03}";
            red = "#${colors.base08}";
            green = "#${colors.base0B}";
            yellow = "#${colors.base0A}";
            blue = "#${colors.base0D}";
            magenta = "#${colors.base0E}";
            cyan = "#${colors.base0C}";
            white = "#${colors.base06}";
          };
          dim = {
            black = "#${colors.base02}";
            red = "#${colors.base08}";
            green = "#${colors.base0B}";
            yellow = "#${colors.base0A}";
            blue = "#${colors.base0D}";
            magenta = "#${colors.base0E}";
            cyan = "#${colors.base0C}";
            white = "#${colors.base05}";
          };
          indexed_colors = [
            {
              index = 16;
              color = "#EF9F76";
            }
            {
              index = 17;
              color = "#${colors.base06}";
            }
          ];
        };
      };
    };
  };

}
