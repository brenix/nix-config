# System configuration for my Raspberry Pi 4
{ inputs, pkgs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./kubernetes.nix
    ../common/global
    ../common/optional/systemd-boot.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    randomizedDelaySec = "120";
    rebootWindow = {
      lower = "03:00";
      upper = "06:00";
    };
    flake = "github:brenix/nixos-config";
    flags = [
      "--recreate-lock-file"
      "--no-write-lock-file"
      "--impure"
    ];
  };

  system.stateVersion = "22.05";
}
