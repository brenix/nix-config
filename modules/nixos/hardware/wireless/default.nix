{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.hardware.wireless;
in {
  options.${namespace}.hardware.wireless = {
    enable = mkEnableOption "Enable wireless networking";
  };

  config = mkIf cfg.enable {
    sops.secrets.wifiNetworks = {
      sopsFile = ../../secrets.yaml;
      neededForUsers = true;
    };

    environment.systemPackages = with pkgs; [
      wpa_supplicant_gui
    ];

    networking.wireless = {
      enable = true;
      fallbackToWPA2 = true;
      secretsFile = config.sops.secrets.wifiNetworks.path;
      networks = {
        "ciphernet" = {
          pskRaw = "ext:ciphernet";
        };
      };

      allowAuxiliaryImperativeNetworks = true;
      userControlled = {
        enable = true;
        group = "network";
      };
      extraConfig = ''
        update_config=1
      '';
    };

    # Ensure group exists
    users.groups.network = {};

    # Fix issue where wpa_supplicant expects a config file
    systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
  };
}
