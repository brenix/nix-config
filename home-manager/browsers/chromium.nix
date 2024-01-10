{ lib, config, ... }:
with lib;
let
  cfg = config.modules.browsers.chromium;
in
{
  options.modules.browsers.chromium = {
    enable = mkEnableOption "enable chromium browser";
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

    home.persistence = {
      "/persist/home/brenix" = {
        directories = [ ".config/chromium" ];
        allowOther = true;
      };
    };
  };
}

