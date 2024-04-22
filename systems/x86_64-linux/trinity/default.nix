{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  profiles.common.enable = true;

  networking.hostName = "neo";

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
  };

  system.stateVersion = "23.11";
}
