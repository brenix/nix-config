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
  networking.useNetworkd = true;
  networking.bridges.br0.interfaces = ["enp7s0" "eno1"];
  networking.interfaces.br0.useDHCP = true;

  systemd.extraConfig = "DefaultLimitNOFILE=4096:524288";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Workaround UEFI issue: https://github.com/NixOS/nixpkgs/issues/75457
    loader.systemd-boot.graceful = true;
  };

  system.stateVersion = "23.11";
}
