{ config, ... }: {

  boot = {
    # Needed to install bootloader
    loader.systemd-boot.graceful = true;
    initrd = {
      availableKernelModules =
        [ "ahci" "xhci_pci" "ehci_pci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-intel" ];
  };

  # Hostname
  networking.hostName = "trinity";

  # Enable DHCP
  systemd.network.networks.enp7s0 = {
    matchConfig = { Name = "enp7s0"; };
    DHCP = "yes";
  };

  # Filesystems
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5796da76-5092-4278-bdbd-2b7a65317407";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D891-9B3F";
    fsType = "vfat";
  };

  # Mounts
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

  # Enable all firmware
  hardware.enableAllFirmware = true;

  home-manager.users.${config.settings.username} = {
    settings = config.settings;
  };

}
