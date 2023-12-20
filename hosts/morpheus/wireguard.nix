{ config, ... }:
{
  sops.secrets.wireguardEndpoint = {
    sopsFile = ./secrets.yaml;
  };

  sops.secrets.wireguardPrivateKey = {
    sopsFile = ./secrets.yaml;
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.10.10.5/32" ];
      dns = [ "10.10.10.1" ];
      privateKeyFile = config.sops.secrets.wireguardPrivateKey.path;

      peers = [
        {
          publicKey = "8TFMhl1fXoOgV6qqUkKwS28T3uMTgQxURMktrtSCOis=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = config.sops.secrets.wireguardEndpoint;
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
