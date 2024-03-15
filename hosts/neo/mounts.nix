{ config, lib, ... }:
let
  hostname = config.networking.hostName;
in
{
  boot.initrd = {
    postDeviceCommands = lib.mkForce (lib.mkBefore ''
      mkdir -p /mnt
      echo "mounting root volume..."
      mount -t btrfs -o subvol=/ /dev/disk/by-label/${hostname} /mnt
      btrfs subvolume list -o /mnt/root |
      cut -f9 -d' ' |
      while read subvolume; do
        echo "deleting subvolume: /$subvolume..."
        btrfs subvolume delete "/mnt/$subvolume" 1>/dev/null
      done &&
      btrfs subvolume delete /mnt/root 1>/dev/null
      echo "restoring blank /root subvolume..."
      btrfs subvolume snapshot /mnt/root-blank /mnt/root 1>/dev/null
      rm -rf /mnt/root/root && mkdir /mnt/root/root
      umount /mnt
    '');
  };

  fileSystems = {
    "/boot" = lib.mkForce {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };

    "/" = lib.mkForce {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=root" "noatime" "compress=zstd" ];
    };

    "/nix" = lib.mkForce {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "compress=zstd" "autodefrag" ];
    };

    "/persist" = lib.mkForce {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=persist" "noatime" "compress=zstd" "autodefrag" ];
      neededForBoot = true;
    };

    "/swap" = lib.mkForce {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
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
    {
      what = "/dev/mapper/data-games";
      where = "/games";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
  ];
}
