{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.alacritty;
in {
  options.${namespace}.programs.terminal.emulators.alacritty = {
    enable = mkBoolOpt false "enable alacritty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        terminal = {
          shell = {
            program = "fish";
          };
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
          offset.y = -3;
          size = mkForce 12;
          bold = {
            family = config.stylix.fonts.monospace.name;
            style = "Regular";
          };
        };
      };
    };
  };
}
