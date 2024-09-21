{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    restic
    rclone
  ];

  sops.secrets.resticPassword = {
    sopsFile = ./secrets.yaml;
  };

  sops.secrets."rclone.conf" = {
    sopsFile = ./secrets.yaml;
    path = "/root/.config/rclone/rclone.conf";
  };

  services.restic.backups = {
    gdrive = {
      repository = "rclone:gdrive:backups/trinity";
      passwordFile = config.sops.secrets.resticPassword.path;
      paths = [
        "/var/openebs/local"
        "/var/lib/rancher/k3s"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
      extraBackupArgs = [
        "--exclude MediaCover"
        "--exclude Metadata"
        "--exclude nix-cache"
        "--iexclude cache"
        "--iexclude crash"
        "--iexclude logs"
        "--exclude cs2"
        "--exclude Pal"
        "--exclude steamapps"
        "--exclude linux64"
        "--exclude containerd"
        "--exclude dl"
        "--exclude server"
        "--exclude models"
      ];
      timerConfig = {
        OnCalendar = "03:00";
      };
    };
  };
}
