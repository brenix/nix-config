{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  networking.hostName = "vm";

  roles = {
    desktop = {
      enable = true;
      addons = {
        gnome.enable = true;
      };
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["console=ttyS0,115200" "loglevel=7" "systemd.log_level=debug"];
  };

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  system.stateVersion = "23.11";
}
