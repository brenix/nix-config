{ lib, hostname, ... }:
{
  boot.initrd = {
    postDeviceCommands = lib.mkBefore ''
      mkdir -p /mnt
      mount -o subvol=/ /dev/disk/by-label/${hostname} /mnt

      echo "Cleaning subvolume"
      btrfs subvolume list -o /mnt/root | cut -f9 -d ' ' |
      while read subvolume; do
        btrfs subvolume delete "/mnt/$subvolume"
      done && btrfs subvolume delete /mnt/root

      echo "Restoring blank subvolume"
      btrfs subvolume snapshot /mnt/root-blank /mnt/root

      umount /mnt
    '';
    supportedFilesystems = [ "btrfs" ];
  };

  fileSystems = {
    #"/" = {
    #  device = "/dev/disk/by-label/${hostname}";
    #  fsType = "btrfs";
    #  options = [ "subvol=root" "noatime" "nodatacow" "nobarrier" ];
    #};

    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=3G" "mode=755" ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "nodatacow" "commit=120" "flushoncommit" ];
    };

    "/persist" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=persist" "noatime" "nodatacow" "commit=120" "flushoncommit" ];
      neededForBoot = true;
    };

    #"/swap" = {
    #  device = "/dev/disk/by-label/${hostname}";
    #  fsType = "btrfs";
    #  options = [ "subvol=swap" "noatime" ];
    #};
  };

  #swapDevices = [{
  #  device = "/swap/swapfile";
  #  size = 4096;
  #}];

}
