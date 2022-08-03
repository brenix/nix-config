{ config, ... }:
let
  inherit (config.colorscheme) colors;
in
{
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        term = "xterm-256color";
        font = "${config.fontProfiles.monospace.family}:pixelsize=14";
        font-bold = "${config.fontProfiles.monospace.family}:pixelsize=14";
        dpi-aware = "auto";
        line-height = "16px";
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
        lines = 100000;
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
