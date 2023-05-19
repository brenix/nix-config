{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    # Needed to install bootloader
    loader.systemd-boot.graceful = true;
    initrd = {
      availableKernelModules = [ "ahci" "xhci_pci" "ehci_pci" "usbhid" "usb_storage" "sd_mod" "dm-snapshot" ];
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
    "/var/lib/containerd" = {
      device = "/dev/disk/by-label/containerd";
      fsType = "xfs";
      options = [ "noatime" ];
    };
  };

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

  systemd.mounts = [
    {
      what = "/dev/mapper/data-config";
      where = "/config";
      type = "xfs";
      options = "rw,noatime";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-media";
      where = "/media";
      type = "xfs";
      options = "rw,noatime";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  nixpkgs.hostPlatform.system = "x86_64-linux";
}
