{ config
, lib
, ...
}:
with lib;
with lib.nixicle; let
  cfg = config.services.ntp;
in
{
  options.services.ntp = with types; {
    enable = mkBoolOpt false "Enable ntp";
    servers = mkOpt (listOf str) [ "time.cloudflare.com" "time.google.com" ] "Custom set of NTP servers from which to synchronise.";
  };

  config = mkIf cfg.enable {
    services.timesyncd = {
      enable = true;
      servers = config.services.ntp.servers;
    };
  };
}
