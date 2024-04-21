{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.profiles.desktop.addons.hyprland;
in {
  options.profiles.desktop.addons.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    profiles.desktop.addons.greetd.enable = true;
    profiles.desktop.addons.xdg-portal.enable = true;
  };
}
