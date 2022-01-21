{ lib, ... }: {

  # Speed up boot
  # https://discourse.nixos.org/t/boot-faster-by-disabling-udev-settle-and-nm-wait-online/6339
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable SSH
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Set NTP servers
  services.timesyncd.servers = lib.mkDefault [
    "192.168.1.1"
    "time.cloudflare.com"
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
  ];

  # Disable X11 askpass
  programs.ssh.askPassword = "";

  # Increase tmpfs storage for /run/user/<uid>
  services.logind.extraConfig = lib.mkDefault ''
    RuntimeDirectorySize=50%
  '';

  # Limit journald
  services.journald.extraConfig = lib.mkDefault ''
    MaxLevelStore=info
    MaxRetentionSec=1week
  '';

}
