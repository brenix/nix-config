{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
  };

  systemd.network.networks.ens33 = {
    matchConfig = { Name = "ens33"; };
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
      what = "/dev/sdb1";
      where = "/home/brenix/.cache";
      type = "btrfs";
      options = "rw,noatime,nodatacow,discard=async";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
}
