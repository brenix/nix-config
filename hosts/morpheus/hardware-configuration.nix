{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
    ];

    initrd.kernelModules = [ ];

    kernelModules = [ ];

    kernelParams = [
      "mitigations=off"
    ];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
  };

  swapDevices = [{
    device = "/swap/swapfile";
    size = 8196;
  }];

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # Fix suspend/wake - https://github.com/NixOS/nixos-hardware/tree/master/framework/13-inch/7040-amd#suspendwake-workaround
  hardware.framework.amd-7040.preventWakeOnAC = true;


  # Bluetooth
  # hardware.bluetooth.enable = true;
  # environment.persistence = {
  #   "/persist".directories = [
  #     "/var/lib/bluetooth"
  #   ];
  # };
}
