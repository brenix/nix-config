{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.notifications.mako;
in {
  options.${namespace}.programs.graphical.notifications.mako = {
    enable = mkBoolOpt false "Enable mako notification daemon";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      # catppuccin.enable = true;
      defaultTimeout = 30000;
    };

    home.packages = with pkgs; [
      libnotify
    ];
  };
}
