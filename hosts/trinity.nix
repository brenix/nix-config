{ config, ... }: {

  boot = { kernelModules = [ "dm-snapshot" ]; };

  # Hostname
  networking.hostName = "trinity";

  # Enable DHCP
  systemd.network.networks.enp7s0 = {
    matchConfig = { Name = "enp7s0"; };
    DHCP = "yes";
  };

  # Filesystems
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/46d2e29d-bdd3-4ad3-b907-41dc56058c9c";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D346-5109";
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
