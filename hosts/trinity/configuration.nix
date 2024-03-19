{ inputs, pkgs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    # ./disks.nix # TODO: uncomment during reinstall
    ./k3s.nix
    ./restic.nix
    ./mounts.nix # TODO: remove during reinstall
    ./nix-cache.nix

    ../../nixos
    ../../nixos/users/brenix.nix
  ];

  modules.nixos = {
    avahi.enable = true;
    auto-login.enable = true;
    auto-upgrade.enable = true;
    clipcat.enable = false;
    ephemeral.enable = true;
    fonts.enable = false;
    gaming.enable = false;
    openconnect.enable = false;
    opengl.enable = false;
    pipewire.enable = false;
    podman.enable = false;
    systemd-boot.enable = true;
    wireless.enable = false;
    xorg.enable = false;
  };

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ ];
    initrd.availableKernelModules = [
      "ahci"
      "dm-snapshot"
      "ehci_pci"
      "sd_mod"
      "usb_storage"
      "usbhid"
      "xhci_pci"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    blacklistedKernelModules = [ ];
    extraModprobeConfig = ''
    '';
  };

  # Networking
  networking = {
    hostName = "trinity";
  };
  networking.useDHCP = pkgs.lib.mkForce false;
  networking.useNetworkd = false;

  systemd.network.enable = true;
  systemd.network.networks.enp7s0 = {
    matchConfig = { Name = "enp7s0"; };
    DHCP = "yes";
    routes = [{
      routeConfig = {
        InitialCongestionWindow = 50;
        InitialAdvertisedReceiveWindow = 50;
      };
    }];
  };

  # Nix
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # Swap
  swapDevices = [{ device = "/swap/swapfile"; }];

  system.stateVersion = "23.11";
}
