# System configuration for my Raspberry Pi 4
{ inputs, pkgs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./kubernetes.nix
    ./restic.nix
    ../common/global
    ../common/optional/ananicy.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/auto-upgrade.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  networking.hostName = "trinity";

  services.irqbalance.enable = true;

  system.stateVersion = "22.05";
}
