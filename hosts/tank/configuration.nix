{ pkgs, lib, ... }: {
  imports = [
    ./disks.nix

    ../../nixos/global
    ../../nixos/users/brenix.nix

    ../../nixos/optional/auto-login.nix
    ../../nixos/optional/ephemeral.nix
    ../../nixos/optional/fonts.nix
    ../../nixos/optional/qemu-guest.nix
    ../../nixos/optional/systemd-boot.nix
    ../../nixos/optional/xorg.nix
  ];

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelParams = [ ];
    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "virtio_scsi"
      "sr_mod"
      "virtio_blk"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    blacklistedKernelModules = [ ];
    extraModprobeConfig = ''
    '';
  };

  # Networking
  networking = {
    hostName = "tank";
    useDHCP = lib.mkDefault true;
  };

  # Nix
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # Programs
  programs = {
    dconf.enable = true;
  };

  # Swap
  swapDevices = [{ device = "/swap/swapfile"; }];

  system.stateVersion = "23.11";
}
