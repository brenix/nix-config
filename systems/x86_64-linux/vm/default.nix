{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  networking = {
    hostName = "vm";
  };

  profiles = {
    desktop = {
      enable = true;
      addons = {
        hyprland.enable = true;
      };
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  system.stateVersion = "23.11";
}
