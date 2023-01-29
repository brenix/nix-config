{ pkgs, ... }:
{
  systemd.user.services.barrier = {
    Unit = {
      Description = "Barrier KVM";
      After = [ "graphical-session=-pre.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.barrier}/bin/barriers --no-restart --no-daemon --no-tray --disable-crypto -c %h/.config/barrier/barrier.conf";
      Restart = "on-failure";
      RestartSec = "30s";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
