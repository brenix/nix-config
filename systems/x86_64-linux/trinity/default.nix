{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix

    # ./k3s.nix
    # ./nix-cache.nix
    # ./restic.nix
  ];

  matrix.roles.common.enable = true;

  environment.systemPackages = with pkgs; [
    sqlite
    fd
  ];

  networking.hostName = "trinity";
  networking.nameservers = ["192.168.1.1"];
  networking.bridges.br0.interfaces = ["enp7s0"];
  networking.bridges.br0.rstp = true;
  networking.interfaces.br0.ipv4.addresses = [
    {
      address = "192.168.1.10";
      prefixLength = 24;
    }
  ];
  networking.interfaces.br0.ipv4.routes = [
    {
      address = "0.0.0.0";
      prefixLength = 0;
      via = "192.168.1.1";
      options = {
        quickack = "1";
        initcwnd = "50";
        initrwnd = "50";
      };
    }
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-server;

    # Workaround UEFI issue: https://github.com/NixOS/nixpkgs/issues/75457
    loader.systemd-boot.graceful = true;
  };

  # HACK: Adds dconf to avoid home-manager issues.
  # This is because gtk.enabled is somehow making it through on a headless system
  programs.dconf.enable = true;

  system.stateVersion = "23.11";
}
