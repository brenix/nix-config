{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.terminals.foot;
in {
  options.cli.terminals.foot = with types; {
    enable = mkBoolOpt false "enable foot terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      catppuccin.enable = true;

      settings = {
        main = {
          term = "foot";
          font = "Monaco Nerd Font Mono:size=14, Noto Color Emoji:size=20";
          font-bold = "Monaco Nerd Font Mono:size=14:weight=Regular";
          line-height = "20px";
          shell = "${pkgs.fish}/bin/fish";
          selection-target = "primary";
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
