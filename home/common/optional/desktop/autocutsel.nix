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
      ExecStartPre = "${pkgs.autocutsel}/bin/autocutsel -fork";
      ExecStart = "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
