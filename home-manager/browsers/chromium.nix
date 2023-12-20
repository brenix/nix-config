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
      commandLineArgs = [ ];
      extensions = { };
    };
  };
}

