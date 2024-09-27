{
  config,
  lib,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.roles.desktop.addons.labwc;
in {
  options.${namespace}.roles.desktop.addons.labwc = {
    enable = mkBoolOpt false "Enable or disable the labwc window manager.";
  };

  config = mkIf cfg.enable {
    programs.dconf.enable = true;

    # FIXME: uwsm doesn't seem to work
    # environment.systemPackages = with pkgs; [
    #   labwc
    # ];

    # programs.uwsm.enable = true;
    # programs.uwsm.waylandCompositors = {
    #   labwc = {
    #     prettyName = "labwc";
    #     comment = "Labwc compositor managed by UWSM";
    #     binPath = "/run/current-system/sw/bin/labwc";
    #   };
    # };

    matrix = {
      roles = {
        desktop.addons = {
          greetd.enable = true;
          xdg-portal.enable = true;
        };
      };
    };
  };
}
