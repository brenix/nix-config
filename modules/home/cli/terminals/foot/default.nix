{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.terminals.foot;
  inherit (config.colorscheme) palette;
in {
  options.cli.terminals.foot = with types; {
    enable = mkBoolOpt false "enable foot terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      # catppuccin.enable = true;

      settings = {
        main = {
          term = "foot";
          font = "Monaco Nerd Font Mono:size=11.5, Noto Color Emoji:size=18";
          font-bold = "Monaco Nerd Font Mono:size=11.5:weight=Regular";
          line-height = "18px";
          shell = "${pkgs.fish}/bin/fish";
          selection-target = "primary";
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
          select-extend = "none";
          primary-paste = "BTN_RIGHT";
        };
      };
    };
  };
}
