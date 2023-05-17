{ config, ... }:
let
  hostname = config.networking.hostName;
in
{
  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "noatime" "size=3G" "mode=755" ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/${hostname}-nix";
      fsType = "xfs";
      options = [ "noatime" "lazytime" ];
    };

    "/persist" = {
      device = "/dev/disk/by-label/${hostname}-persist";
      fsType = "xfs";
      options = [ "noatime" "lazytime" ];
      neededForBoot = true;
    };
  };
}
