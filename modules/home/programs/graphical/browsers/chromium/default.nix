{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.browsers.chromium;
in {
  options.${namespace}.programs.graphical.browsers.chromium = {
    enable = mkBoolOpt false "enable chromium browser";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      commandLineArgs = [
        "--custom-ntp=about:blank"
        "--disable-search-engine-collection"
        "--enable-quic"
        "--max-connections-per-host=32"
        "--no-pings"
        "--enable-features=AsyncDns,BackForwardCache,SetIpv6ProbeFalse"
      ];
    };
  };
}
