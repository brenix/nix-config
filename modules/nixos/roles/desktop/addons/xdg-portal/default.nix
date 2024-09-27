{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.roles.desktop.addons.xdg-portal;
in {
  options.${namespace}.roles.desktop.addons.xdg-portal = {
    enable = mkBoolOpt false "Whether or not to add support for xdg portal.";
  };

  config = mkIf cfg.enable {
    xdg = {
      autostart.enable = true;
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          # xdg-desktop-portal-hyprland
        ];
        config.common.default = "*";
      };
    };
  };
}
