{ config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.vmware-guest;
in
{
  options.modules.nixos.vmware-guest = {
    enable = mkEnableOption "Enable vmware-guest";
  };

  config = mkIf cfg.enable {

    virtualisation.vmware.guest.enable = true;
    environment.systemPackages = with pkgs; [ xorg.xf86videovmware ];

    # Host mounts under /host
    fileSystems."/host" = {
      fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
      device = ".host:/";
      options = [
        "umask=22"
        "uid=1000"
        "gid=1000"
        "allow_other"
        "auto_unmount"
        "defaults"
      ];
    };
  };
}
