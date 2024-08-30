{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkForce;
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
          font = with config.stylix.fonts; mkForce "${monospace.name}:size=12";
          font-bold = with config.stylix.fonts; "${monospace.name}:size=12";
          line-height = "18px";
          # letter-spacing = -0.1;
          vertical-letter-offset = "-1px";
          selection-target = "primary";
          shell = "${pkgs.fish}/bin/fish";
          term = "xterm-256color";
        };

        cursor = {
          style = "underline";
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
