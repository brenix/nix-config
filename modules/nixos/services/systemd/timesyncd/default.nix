{
  config,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.services.systemd.timesyncd;
in {
  options.services.systemd.timesyncd = with types; {
    enable = mkBoolOpt false "Enable timesyncd";
    servers = mkOpt (listOf str) ["time.cloudflare.com" "time.google.com"] "Custom set of NTP servers from which to synchronise.";
  };

  config = mkIf cfg.enable {
    services.timesyncd = {
      enable = true;
      servers = config.services.systemd.timesyncd.servers;
    };
  };
}
