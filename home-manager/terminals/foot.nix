{ config, lib, ... }:
with lib;
let
  cfg = config.modules.terminals.foot;
  inherit (config.colorscheme) colors;
in
{
  options.modules.terminals.foot = {
    enable = mkEnableOption "enable foot terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          # term = "xterm-256color";
          term = "foot";
          font = "${config.my.settings.fonts.monospace}:size=10, JoyPixels:size=10";
          line-height = "11px";
          shell = "${config.my.settings.default.shell}";
          pad = "8x6";
          selection-target = "clipboard";
          dpi-aware = "yes";
        };

        colors = {
          foreground = colors.base05;
          background = colors.base00;

          regular0 = colors.base02;
          regular1 = colors.base08;
          regular2 = colors.base0B;
          regular3 = colors.base0A;
          regular4 = colors.base0D;
          regular5 = colors.base0E;
          regular6 = colors.base0C;
          regular7 = colors.base05;

          bright0 = colors.base03;
          bright1 = colors.base08;
          bright2 = colors.base0B;
          bright3 = colors.base0A;
          bright4 = colors.base0D;
          bright5 = colors.base0E;
          bright6 = colors.base0C;
          bright7 = colors.base06;
        };

        scrollback = {
          lines = 10000;
        };

        mouse = {
          hide-when-typing = "yes";
        };

        mouse-bindings = {
          select-extend = "BTN_MIDDLE";
          primary-paste = "BTN_RIGHT";
        };
      };
    };
  };
}
