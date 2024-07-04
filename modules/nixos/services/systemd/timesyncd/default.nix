{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.services.systemd.timesyncd;
in {
  options.${namespace}.services.systemd.timesyncd = with types; {
    enable = mkBoolOpt false "Enable timesyncd";
    servers = mkOpt (listOf str) ["time.cloudflare.com" "time.google.com"] "Custom set of NTP servers from which to synchronise.";
  };

  config = mkIf cfg.enable {
    services.timesyncd = {
      enable = true;
      servers = config.${namespace}.services.systemd.timesyncd.servers;
    };
  };
}
