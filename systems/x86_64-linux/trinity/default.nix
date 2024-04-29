{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix

    ./k3s.nix
    ./nix-cache.nix
    ./restic.nix
  ];

  roles.common.enable = true;

  networking.hostName = "trinity";
  networking.useDHCP = pkgs.lib.mkForce false;
  networking.useNetworkd = false;
  systemd.network.enable = true;
  systemd.network.networks.enp7s0 = {
    matchConfig = {Name = "enp7s0";};
    DHCP = "yes";
    routes = [
      {
        routeConfig = {
          InitialCongestionWindow = 50;
          InitialAdvertisedReceiveWindow = 50;
        };
      }
    ];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Workaround UEFI issues
    loader.systemd-boot.graceful = true;
  };

  system.stateVersion = "23.11";
}
