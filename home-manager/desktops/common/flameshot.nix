{ lib, config, ... }:
with lib;
let
  cfg = config.modules.wms.screenshots.flameshot;
in
{
  options.modules.wms.screenshots.flameshot = {
    enable = mkEnableOption "enable flameshot screenshot tool";
  };

  config = mkIf cfg.enable {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };
  };
}
