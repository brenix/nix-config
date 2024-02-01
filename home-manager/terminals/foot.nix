{ config, lib, ... }:
with lib;
let
  cfg = config.modules.terminals.foot;
  inherit (config.colorscheme) palette;
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
          foreground = palette.base05;
          background = palette.base00;

          regular0 = palette.base02;
          regular1 = palette.base08;
          regular2 = palette.base0B;
          regular3 = palette.base0A;
          regular4 = palette.base0D;
          regular5 = palette.base0E;
          regular6 = palette.base0C;
          regular7 = palette.base05;

          bright0 = palette.base03;
          bright1 = palette.base08;
          bright2 = palette.base0B;
          bright3 = palette.base0A;
          bright4 = palette.base0D;
          bright5 = palette.base0E;
          bright6 = palette.base0C;
          bright7 = palette.base06;
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
