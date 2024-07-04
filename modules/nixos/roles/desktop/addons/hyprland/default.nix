{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.roles.desktop.addons.hyprland;
in {
  options.${namespace}.roles.desktop.addons.hyprland = {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.hyprland.enable = true;
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
