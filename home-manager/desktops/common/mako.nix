{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.wms.notifications.mako;
in
{
  options.modules.wms.notifications.mako = {
    enable = mkEnableOption "enable mako notification manager";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
      backgroundColor = "#${config.colorscheme.palette.base00}";
      textColor = "#${config.colorscheme.palette.base05}";
      borderColor = "#${config.colorscheme.palette.base0D}";
      progressColor = "over #${config.colorscheme.palette.base02}";
      extraConfig = ''
        [urgency=high]
        border-color=#${config.colorscheme.palette.base09}
      '';
    };

    home.packages = with pkgs; [
      libnotify
    ];
  };
}
