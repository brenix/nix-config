{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  hardware = {
    wootingKeyboard.enable = true;
    logitechMouse.enable = true;
  };

  services = {
    virtualisation.kvm.enable = true;
    virtualisation.podman.enable = true;
  };

  profiles = {
    desktop = {
      enable = true;
      addons = {
        hyprland.enable = true;
      };
    };
  };

  networking.hostName = "neo";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  system.stateVersion = "23.11";
}
