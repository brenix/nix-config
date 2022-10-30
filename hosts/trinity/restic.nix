{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    restic
    rclone
  ];

  sops.secrets.restic-password = {
    sopsFile = ./secrets.yaml;
  };

  sops.secrets."rclone.conf" = {
    sopsFile = ./secrets.yaml;
    path = "/root/.config/rclone/rclone.conf";
  };

  services.restic.backups = {
    gdrive = {
      repository = "rclone:gdrive:backup/trinity";
      passwordFile = config.sops.secrets.restic-password.path;
      paths = [
        "/config"
        "/var/openebs/local"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
      extraBackupArgs = [
        "--exclude MediaCover"
        "--exclude Metadata"
        "--iexclude cache"
        "--iexclude crash"
        "--iexclude logs"
      ];
    };
  };
}
