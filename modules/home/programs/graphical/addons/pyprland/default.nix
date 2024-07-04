{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.addons.pyprland;
in {
  options.${namespace}.programs.graphical.addons.pyprland = {
    enable = mkBoolOpt false "Enable pyprland plugins for hyprland";
  };

  config = mkIf cfg.enable {
    xdg.configFile."hypr/pyprland.toml".source = ./pyprland.toml;

    home = {
      packages = with pkgs; [pyprland];
    };
  };
}
