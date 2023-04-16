{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    # Needed to install bootloader
    loader.systemd-boot.graceful = true;
    initrd = {
      availableKernelModules = [ "ahci" "xhci_pci" "ehci_pci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
    "/var/lib/containerd" = {
      device = "/dev/disk/by-label/containerd";
      fsType = "btrfs";
      options = [ "noatime" "nodatacow" "commit=120" "flushoncommit" "discard=async" ];
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
      type = "ext4";
      options = "rw,noatime,barrier=0";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-downloads";
      where = "/downloads";
      type = "ext4";
      options = "rw,noatime,barrier=0";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  nixpkgs.hostPlatform.system = "x86_64-linux";
}
