{ config, lib, ... }:
with lib;
let
  cfg = config.modules.terminals.foot;
in
{
  options.modules.terminals.foot = {
    enable = mkEnableOption "enable foot terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "foot";
          font = "${config.my.settings.fonts.monospace}:size=10.5, JoyPixels:size=10.5";
          font-bold = "${config.my.settings.fonts.monospace}:size=10.5, JoyPixels:size=10.5";
          font-italic = "${config.my.settings.fonts.monospace}:size=10.5, JoyPixels:size=10.5";
          # font = "Terminus:size=10, JoyPixels:size=10";
          # font-bold = "Terminus:size=10, JoyPixels:size=10";
          # font-italic = "Terminus:size=10, JoyPixels:size=10";
          line-height = "16px";
          # vertical-letter-offset = "1px";
          box-drawings-uses-font-glyphs = "yes";
          shell = "${config.my.settings.default.shell}";
          selection-target = "primary";
        };

        colors = {
          foreground = config.colorscheme.palette.base05;
          background = config.colorscheme.palette.base00;

          regular0 = config.colorscheme.palette.base02;
          regular1 = config.colorscheme.palette.base08;
          regular2 = config.colorscheme.palette.base0B;
          regular3 = config.colorscheme.palette.base0A;
          regular4 = config.colorscheme.palette.base0D;
          regular5 = config.colorscheme.palette.base0E;
          regular6 = config.colorscheme.palette.base0C;
          regular7 = config.colorscheme.palette.base05;

          bright0 = config.colorscheme.palette.base03;
          bright1 = config.colorscheme.palette.base08;
          bright2 = config.colorscheme.palette.base0B;
          bright3 = config.colorscheme.palette.base0A;
          bright4 = config.colorscheme.palette.base0D;
          bright5 = config.colorscheme.palette.base0E;
          bright6 = config.colorscheme.palette.base0C;
          bright7 = config.colorscheme.palette.base06;
        };

        scrollback = {
          lines = 10000;
        };

        mouse = {
          hide-when-typing = "yes";
        };

        mouse-bindings = {
          select-extend = "none";
          primary-paste = "BTN_RIGHT";
        };
      };
    };
  };
}
