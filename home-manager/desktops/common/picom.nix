{ config, lib, ... }:
with lib;
let
  cfg = config.modules.wms.compositor.picom;
in
{
  options.modules.wms.compositor.picom = {
    enable = mkEnableOption "enable picom compositor";
  };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      activeOpacity = 1.0;
      inactiveOpacity = 1.0;
      shadow = true;
      fade = false;
      backend = "glx";
      opacityRules = [
        "80:class_i ?= 'alacritty'"
      ];
      settings = {
        blur = {
          method = "gaussian";
          size = 10;
          deviation = 5.0;
        };
      };
    };
  };
}
