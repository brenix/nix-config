{ inputs, pkgs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    # ./disks.nix # TODO: uncomment during reinstall
    ./k3s.nix
    # ./k0s.nix
    # ./kubernetes.nix
    ./restic.nix
    ./mounts.nix # TODO: remove during reinstall

    ../../nixos/global
    ../../nixos/users/brenix.nix

    ../../nixos/optional/auto-login.nix
    ../../nixos/optional/auto-upgrade.nix
    ../../nixos/optional/ephemeral.nix
    ../../nixos/optional/systemd-boot.nix
  ];

  # Boot
  boot = {
    # kernelPackages = pkgs.linuxPackages_cachyos;
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

  # Programs
  services.irqbalance.enable = true;

  # Swap
  swapDevices = [{ device = "/swap/swapfile"; }];

  system.stateVersion = "23.11";
}
