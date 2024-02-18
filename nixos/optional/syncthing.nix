{ config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.syncthing;
in
{
  options.modules.nixos.syncthing = {
    enable = mkEnableOption "Enable syncthing";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = "brenix";
      overrideDevices = true;
      overrideFolders = true;
      openDefaultPorts = true;
      dataDir = "/home/brenix/syncthing";
    };

    environment.persistence = {
      "/persist".directories = [
        "/home/brenix/syncthing"
      ];
    };
  };
}
