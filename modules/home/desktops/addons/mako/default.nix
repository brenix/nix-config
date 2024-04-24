{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.desktops.addons.mako;
in {
  options.desktops.addons.mako = {
    enable = mkEnableOption "Enable mako notification daemon";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      catppuccin.enable = true;
      font = "Terminus 12";
    };

    home.packages = with pkgs; [
      libnotify
    ];
  };
}
