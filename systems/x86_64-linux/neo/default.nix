{ pkgs
, lib
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  hardware = {
    wooting.enable = true;
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
    supportedFilesystems = lib.mkForce [ "btrfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    resumeDevice = "/dev/disk/by-label/nixos";
  };

  system.stateVersion = "23.11";
}
