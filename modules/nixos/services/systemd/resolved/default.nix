{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.services.systemd.resolved;
in {
  options.services.systemd.resolved = with types; {
    enable = mkBoolOpt false "Enable resolved";
    domains = mkOpt (listOf str) [] "List of domains to use as search suffixes.";
  };

  config = mkIf cfg.enable {
    services.resolved = {
      enable = true;
      domains = config.services.systemd.resolved.domains;
      dnssec = "false";
    };
  };
}
