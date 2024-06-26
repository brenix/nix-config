{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.terminals.alacritty;
in {
  options.cli.terminals.alacritty = with types; {
    enable = mkBoolOpt false "enable alacritty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      catppuccin.enable = false;

      settings = {
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
            family = "Monaco Nerd Font Mono";
            style = "Regular";
          };
          bold = {
            family = "Monaco Nerd Font Mono";
            style = "Regular";
          };
          italic = {
            family = "Monaco Nerd Font Mono";
            style = "Italic";
          };
          size = 14.0;
          offset.y = -2;
        };
      };
    };
  };
}
