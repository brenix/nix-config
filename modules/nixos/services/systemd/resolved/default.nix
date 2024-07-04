{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.services.systemd.resolved;
in {
  options.${namespace}.services.systemd.resolved = with types; {
    enable = mkBoolOpt false "Enable resolved";
    domains = mkOpt (listOf str) [] "List of domains to use as search suffixes.";
  };

  config = mkIf cfg.enable {
    services.resolved = {
      enable = true;
      domains = config.${namespace}.services.systemd.resolved.domains;
      dnssec = "false";
    };
  };
}
