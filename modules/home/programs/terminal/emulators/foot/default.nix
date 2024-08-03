{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.foot;
in {
  options.${namespace}.programs.terminal.emulators.foot = {
    enable = mkBoolOpt false "enable foot terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      # catppuccin.enable = true;

      settings = {
        main = {
          # font = "JetBrainsMono Nerd Font:size=11.5:weight=Regular, Noto Color Emoji:size=18";
          font-bold = with config.stylix.fonts; "${monospace.name}:size=${toString sizes.terminal}";
          line-height = "14px";
          selection-target = "primary";
          shell = "${pkgs.fish}/bin/fish";
          term = "xterm-256color";
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
