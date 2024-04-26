{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.system.impermanence;
in {
  options.system.impermanence = with types; {
    enable = mkBoolOpt false "Enable impermanence";
  };

  options.environment = with types; {
    persist =
      mkOpt attrs
      {
        directories = [
          "/var/lib/systemd"
          "/var/lib/nixos"
          "/var/log"
        ];
        files = [
          "/etc/machine-id"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
        ];
      } "Files and directories to persist";
  };

  config = {
    boot.initrd.postDeviceCommands = mkIf cfg.enable (lib.mkAfter ''
      mkdir /mnt
      mount -t btrfs -o subvol=/ /dev/disk/by-label/nixos /mnt
      btrfs subvolume list -o /mnt/root | cut -f 9- -d ' ' | while read subvolume; do
        echo "deleting subvolume: /$subvolume..."
        btrfs subvolume delete "/mnt/$subvolume" 1>/dev/null
      done &&
      btrfs subvolume delete /mnt/root 1>/dev/null
      echo "restoring blank /root subvolume..."
      btrfs subvolume snapshot /mnt/root-blank /mnt/root 1>/dev/null
      rm -rf /mnt/root/root && mkdir /mnt/root/root
      umount /mnt
    '');

    environment.persistence."/persist" = mkIf cfg.enable (mkAliasDefinitions options.environment.persist);
  };
}
