{ lib, pkgs, ... }:
{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "sd_mod"
      "usb_storage"
      "usbhid"
      "xhci_pci"
    ];

    initrd.kernelModules = [
      "amdgpu"
    ];

    kernelModules = [
      "dm-snapshot"
      "i2c-dev"
      "i2c-piix4"
      "k10temp"
      "kvm-amd"
    ];

    blacklistedKernelModules = [
      "sp5100_tco"
      "nouveau"
      "iwlwifi"
      "mac80211"
      "iTCO_wdt"
    ];

    kernelParams = [
      "mitigations=off"
      "systemd.unified_cgroup_hierarchy=1"
      "tsc=reliable"
      "usbcore.autosuspend=-1"
    ];

    extraModprobeConfig = ''
      options usbhid kbpoll=1
      options usbhid mousepoll=1
    '';
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
  };

  systemd.mounts = [
    {
      what = "/dev/mapper/data-cache";
      where = "/home/brenix/.cache";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-work";
      where = "/home/brenix/work";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-downloads";
      where = "/home/brenix/downloads";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-containers";
      where = "/home/brenix/.containers";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
    # {
    #   what = "/dev/mapper/data-games";
    #   where = "/games";
    #   type = "xfs";
    #   options = "rw,noatime,lazytime";
    #   wantedBy = [ "multi-user.target" ];
    # }
  ];

  services.udev.packages = [ pkgs.wooting-udev-rules ];

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

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.opengl.enable = true;
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # Bluetooth
  # hardware.bluetooth.enable = true;
  # environment.persistence = {
  #   "/persist".directories = [
  #     "/var/lib/bluetooth"
  #   ];
  # };
}
