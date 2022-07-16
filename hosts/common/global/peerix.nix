{ config, inputs, ... }:
{
  imports = [ inputs.peerix.nixosModules.peerix ];

  services.peerix = {
    enable = true;
    openFirewall = true;
    privateKeyFile = config.sops.secrets.peerix-key.path;
    publicKey = "peerix:FMD03BgbcuB8JRU10rpr/bxLBt2UW9kIjCGY2vVjfz8=";
    user = "peerix";
    group = "peerix";
  };
  sops.secrets.peerix-key = {
    sopsFile = ../secrets.yaml;
    owner = "peerix";
    group = "peerix";
  };

  users.users.peerix = {
    isSystemUser = true;
    group = "peerix";
  };
  users.groups.peerix = { };
}
