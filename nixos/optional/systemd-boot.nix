{ config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.systemd-boot;
in
{
  options.modules.nixos.systemd-boot = {
    enable = mkEnableOption "Enable systemd-boot";
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 10;
        systemd-boot.editor = true;
        systemd-boot.consoleMode = "max";
      };
    };
  };
}
