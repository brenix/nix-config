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

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  nixpkgs.hostPlatform.system = "x86_64-linux";


  # Bluetooth
  # hardware.bluetooth.enable = true;
  # environment.persistence = {
  #   "/persist".directories = [
  #     "/var/lib/bluetooth"
  #   ];
  # };
}
