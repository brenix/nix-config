{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix

    ./wireguard.nix
  ];

  services = {
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
      SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="amdgpu_bl0", ATTR{brightness}="55"
    '';
  };

  matrix = {
    roles = {
      desktop = {
        enable = true;
        addons = {
          labwc.enable = true;
        };
      };
    };

    services = {
      virtualisation.podman.enable = true;
    };

    hardware = {
      wireless.enable = true;
    };
  };

  networking.hostName = "morpheus";
  networking.nameservers = ["192.168.1.1" "1.1.1.1"];

  boot = {
    kernelParams = [
      "resume_offset=533760"
    ];
    supportedFilesystems = lib.mkForce ["btrfs"];
    kernelPackages = pkgs.linuxPackages_cachyos;
    resumeDevice = "/dev/disk/by-label/nixos";
  };

  system.stateVersion = "23.11";
}
