{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.modules.nixos.xdg-portal;
in
{
  options.modules.nixos.xdg-portal = {
    enable = mkEnableOption "Enable xdg-portal";
  };

  config = mkIf cfg.enable {
    xdg = {
      autostart.enable = true;
      portal = {
        enable = true;
        config.common.default = "hyprland";
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
        ];
      };
    };
  };
}
