{ config, ... }:
{
  sops.secrets.wifiNetworks = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = true;
    environmentFile = config.sops.secrets.wifiNetworks.path;
    networks = {
      "ciphernet" = {
        psk = "@CIPHERNET@";
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
  users.groups.network = { };

  # Fix issue where wpa_supplicant expects a config file
  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
