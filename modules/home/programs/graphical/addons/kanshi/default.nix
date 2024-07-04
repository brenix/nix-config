{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.addons.kanshi;
in {
  options.${namespace}.programs.graphical.addons.kanshi = {
    enable = mkBoolOpt false "Enable kanshi display addon";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kanshi
    ];

    services.kanshi = {
      enable = true;
      package = pkgs.kanshi;
      systemdTarget = "";
      settings = [
        {
          profile.name = "framework";
          profile.outputs = [
            {
              criteria = "eDP-1";
              scale = 1.0;
              status = "enable";
            }
          ];
        }
        {
          profile.name = "dual";
          profile.outputs = [
            {
              criteria = "LG Electronics LG ULTRAGEAR 105NTSUA9054";
              position = "0,0";
              mode = "2560x1440@165Hz";
              status = "enable";
            }
            {
              criteria = "LG Electronics LG ULTRAGEAR 105NTZNA9053";
              position = "2560,0";
              mode = "2560x1440@143.93Hz";
              status = "enable";
            }
          ];
        }
        {
          profile.name = "vfio";
          profile.outputs = [
            {
              criteria = "LG Electronics LG ULTRAGEAR 105NTSUA9054";
              position = "0,0";
              mode = "2560x1440@165Hz";
              status = "enable";
            }
            {
              criteria = "LG Electronics LG ULTRAGEAR 105NTZNA9053";
              status = "disable";
            }
          ];
        }
        {
          profile.name = "work";
          profile.outputs = [
            {
              criteria = "LG Electronics LG ULTRAGEAR 105NTSUA9054";
              status = "disable";
            }
            {
              criteria = "LG Electronics LG ULTRAGEAR 105NTZNA9053";
              position = "0,0";
              mode = "2560x1440@143.93Hz";
              status = "enable";
            }
          ];
        }
      ];
    };
  };
}
