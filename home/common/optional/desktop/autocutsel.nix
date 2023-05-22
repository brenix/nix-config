{ pkgs, ... }:
{
  systemd.user.services."autocutsel" = {
    Unit = {
      Description = "AutoCutSel";
    };

    Service = {
      Type = "forking";
      Restart = "always";
      RestartSec = 2;
      ExecStart = "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
