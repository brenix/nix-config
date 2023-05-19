{
  imports = [
    ../common/optional/ephemeral-xfs.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" "dm_mod" ];
      kernelModules = [ "dm_mod" ];
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

  nixpkgs.hostPlatform.system = "x86_64-linux";
}
