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
      settings = {
        main = {
          font = mkForce "Terminus:pixelsize=14";
          font-bold = mkForce "Terminus:pixelsize=14";
          line-height = "13px";
          # letter-spacing = -0.1;
          # vertical-letter-offset = "-4px";
          selection-target = "primary";
          shell = "${pkgs.fish}/bin/fish";
          term = "xterm-256color";
        };

        colors = {
          alpha = mkForce 0.8;
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
