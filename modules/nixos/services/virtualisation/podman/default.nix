{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.virtualisation.podman;
in {
  options.${namespace}.services.virtualisation.podman = {
    enable = mkBoolOpt false "Enable podman";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerSocket.enable = true;
        dockerCompat = true;
        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };
    };
  };
}
