{ config, ... }:
{
  sops.secrets.wireguardConfig = {
    sopsFile = ./secrets.yaml;
  };

  environment.etc."wireguard/wg0.conf".source = config.sops.secrets.wireguardConfig.path;

  # NOTE: Use the followng to automatically maintain the wireguard connection
  # networking.wg-quick.interfaces = {
  #   wg0 = {
  #     address = [ ];
  #     dns = [ ];
  #     privateKeyFile = config.sops.secrets.wireguardPrivateKey.path;

  #     peers = [
  #       {
  #         publicKey = "";
  #         allowedIPs = [ "0.0.0.0/0" ];
  #         endpoint = "";
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };
}
