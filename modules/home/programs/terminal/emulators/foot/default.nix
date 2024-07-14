{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  # inherit (config.colorscheme) palette;

  cfg = config.${namespace}.programs.terminal.emulators.foot;
in {
  options.${namespace}.programs.terminal.emulators.foot = {
    enable = mkBoolOpt false "enable foot terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      catppuccin.enable = true;

      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font:size=10, Noto Color Emoji:size=18";
          font-bold = "JetBrainsMono Nerd Font:size=10:weight=Regular";
          line-height = "14px";
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
