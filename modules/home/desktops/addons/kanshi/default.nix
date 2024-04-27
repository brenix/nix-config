{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.desktops.addons.kanshi;
in {
  options.desktops.addons.kanshi = {
    enable = mkEnableOption "Enable kanshi display addon";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kanshi
    ];

    services.kanshi = {
      enable = true;
      package = pkgs.kanshi;
      systemdTarget = "";
      profiles = {
        framework = {
          outputs = [
            {
              criteria = "eDP-1";
              scale = 1.0;
              status = "enable";
            }
          ];
        };
        desktop = {
          outputs = [
            {
              criteria = "LG Electronics LG ULTRAGEAR 105NTSUA9054";
              position = "0,0";
              mode = "2560x1440@165Hz";
            }
            {
              criteria = "LG Electronics LG ULTRAGEAR 105NTZNA9053";
              position = "2560,0";
              mode = "2560x1440@143.93Hz";
            }
          ];
        };
      };
    };
  };
}
