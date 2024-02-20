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
          # font = "${config.my.settings.fonts.monospace}:size=11.5, JoyPixels:size=11.5";
          font = "${config.my.settings.fonts.monospace}:size=11, JoyPixels:size=11";
          font-bold = "${config.my.settings.fonts.monospace}:size=11, JoyPixels:size=11";
          font-italic = "${config.my.settings.fonts.monospace}:size=11, JoyPixels:size=11";
          line-height = "16px";
          # vertical-letter-offset = "1px";
          box-drawings-uses-font-glyphs = "yes";
          shell = "${config.my.settings.default.shell}";
          selection-target = "clipboard";
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
          select-extend = "BTN_MIDDLE";
          primary-paste = "BTN_RIGHT";
        };
      };
    };
  };
}
